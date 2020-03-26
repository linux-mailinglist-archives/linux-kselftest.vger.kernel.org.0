Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23FF1949A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 21:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgCZU5j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 16:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCZU5j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 16:57:39 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8966D2070A;
        Thu, 26 Mar 2020 20:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585256258;
        bh=Im3YvdRgBEVJ9ZM2Xev9HOTBy0ZE+3Jgc6KTzGlAjAk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bHH5GxZgYQoHplCmCOr+5lnw4DdMYOTnxNkKs/wJ38V4IudUifH1EqMyK76Ahmt/c
         itNmkPDWUN3ZvRhbKATcItLcn4AK2Qajc5azSys5nPbhaAr97hVldnmWwvezS1lkt5
         o3Dsa+3KeEgwlEP3gbMwospIe5yapYc30uMn9GUM=
Subject: Re: [RFC v3 0/3] Fix errors when try to build kvm selftests on
 specified output
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200326030750.173972-1-xiaoyao.li@intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <41d5d89e-79c2-6f7d-de3e-ca3255e910e8@kernel.org>
Date:   Thu, 26 Mar 2020 14:57:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326030750.173972-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/20 9:07 PM, Xiaoyao Li wrote:
> Hi Shuah,
> 
> Hope you're happy with this version that I only touch KVM's Makefile.
> 
> I attempted to build KVM selftests on a specified dir, unfortunately
> neither	"make O=/path/to/mydir TARGETS=kvm" in tools/testing/selftests, nor
> "make OUTPUT=/path/to/mydir" in tools/testing/selftests/kvm work.
> 

Why are you running "make OUTPUT=/path/to/mydir"

It isn't correct.

make O=/path/to/mydir is what you have to use. Please main Makefile
as well for O= and KBUILD_OUTPUT usages.

Please see Documentation/dev-tools/kselftest.rst for use-cases.

make O=/path/to/mydir TARGETS=kvm is a right use-case and I can see
it will fail to create x86_64 directory.

Let's start with the following two commands and try to fix the
problems you are seeing.

make O=/path/to/mydir in kvm directory (this is supported,
however, the following command from the main Makefile is
recommended use.)

 From main Makefile in kernel srcdir
make O=/path/to/mydir TARGETS=kvm

Also, just build isn't sufficient for you to be able to run the
tests.

make kselftest-install O=/path/to/mydir TARGETS=kvm will generate
run script.

thanks,
-- Shuah
