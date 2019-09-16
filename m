Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A2B39A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfIPLma (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 07:42:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41436 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPLma (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 07:42:30 -0400
Received: from static-dcd-cqq-121001.business.bouyguestelecom.com ([212.194.121.1] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i9pOm-0001pe-J6; Mon, 16 Sep 2019 11:42:28 +0000
Date:   Mon, 16 Sep 2019 13:42:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, Adrian Reber <areber@redhat.com>
Subject: Re: [PATCH v3 0/6] Update clone3 self-tests
Message-ID: <20190916114227.b4rgvpktde2zlkjp@wittgenstein>
References: <cover.1568224280.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1568224280.git.esyr@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 11, 2019 at 07:01:54PM +0100, Eugene Syromiatnikov wrote:
> Hello.
> 
> This patch set updates clone3 selftest in several aspects:
>  - adding checks for exit_signal invalid values handling;
>  - adding clone3 to selftests targets;
>  - enabling clone3 tests on all architectures;
>  - minor cleanups of the clone3 test.
> 
> This respin alignes additional clone3 self-tests with v3 of the
> exit_signal checking patch[1].
> 
> Applied on top of brauer/linux.git/for-next.

Just base it on v5.3. That should be easier for everyone. :)

Christian
