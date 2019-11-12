Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDCF8CD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 11:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfKLK2U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 05:28:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46656 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfKLK2T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 05:28:19 -0500
Received: from p54ac5726.dip0.t-ipconnect.de ([84.172.87.38] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iUTPE-0003ag-9W; Tue, 12 Nov 2019 10:28:16 +0000
Date:   Tue, 12 Nov 2019 11:28:15 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] selftests: add tests for clone3()
Message-ID: <20191112102814.xkml5etvogzsr7xq@wittgenstein>
References: <20191112095851.811884-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191112095851.811884-1-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 12, 2019 at 10:58:51AM +0100, Adrian Reber wrote:
> This adds tests for clone3() with different values and sizes
> of struct clone_args.
> 
> This selftest was initially part of of the clone3() with PID selftest.
> After that patch was almost merged Eugene sent out a couple of patches
> to fix problems with these test.
> 
> This commit now only contains the clone3() selftest after the LPC
> decision to rework clone3() with PID to allow setting the PID in
> multiple PID namespaces including all of Eugene's patches.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> Signed-off-by: Adrian Reber <areber@redhat.com>

Queuing up for 5.5.
Thanks, Adrian!

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
