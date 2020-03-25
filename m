Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30B192DEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 17:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCYQNv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 12:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbgCYQNv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 12:13:51 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7641720409;
        Wed, 25 Mar 2020 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585152830;
        bh=z/l7SBBshWOFYbBGR0ClUkeQrd+UBb2CWsZuH43i4Vg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d5srGXVBWjNKP/w4N+eoVs88y3PQJBDFqAEI8Qpi/R/mv7gG84m3wE1+TDSovJtiw
         ruLJW+9oq2T58EGMsju0piBrSirMWrctSS4dxMbZ15nrmdYnDSVUnhpvLQhV7keyQr
         8G3VNE98fkGr35AEvcwLw5c7slY680aAF+jKxojQ=
Subject: Re: [PATCH v2 0/6] Fix errors when try to build kvm selftests on
 specified output
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200325140133.103236-1-xiaoyao.li@intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <8e5a7de6-25f3-7979-c6b9-49e1ea717f8e@kernel.org>
Date:   Wed, 25 Mar 2020 10:12:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325140133.103236-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/20 8:01 AM, Xiaoyao Li wrote:
> I attempted to build KVM selftests on a specified dir, unfortunately
> neither	"make O=/path/to/mydir TARGETS=kvm" in tools/testing/selftests, nor
> "make OUTPUT=/path/to/mydir" in tools/testing/selftests/kvm work.
> 

Please elaborate on the problems you are seeing. I would like you
to describe in detail the problems you are seeing and how you are
fixing them in this patch series.

The problem you are fixing here is subdir structure not being
supported for relocatable builds and the Makefile not being
able to locate headers files. These are issues, however, these
need to be fixed in the kvm Makefile.

Please look at arm64, android, futex tests as examples. lib.mk
and main selftests Makefile allow for overrides for make targets.
When a test has sub-dir structure and libraries, it is easier to
handle these in the individual Makefile.

Please fix the problems you are seeing in kvm Makefile.

 >I only test the sub TARGET of kvm.
 >In theory, it won't break other TARGET of selftests.

When you change lib.mk which is a common infrastructure, theory
doesn't help. Statements like this make me very reluctant to
accept patches. :)

This is one reason why I asked Paolo to drop these patches.

thanks,
-- Shuah
