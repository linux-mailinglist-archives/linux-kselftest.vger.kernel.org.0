Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6367D9068
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389712AbfJPMHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 08:07:18 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:38415 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389706AbfJPMHS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 08:07:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 910045D69;
        Wed, 16 Oct 2019 08:07:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 16 Oct 2019 08:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kellner.me; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=mesmtp;
         bh=OecV6gEzkWN5e1WerUgpDBIBDyqRf7tuFxLChH5uBYw=; b=HBG1SF8OlVit
        2UIicSdz+6lkUbWl1NWuVxBo/frtAILVRN6DsBSBSyipekvI7tdpLk1pKwie27Xe
        lZwr+2gY89ueiL2bvAUdfRncA8lGiHxG46I7bO80jF4PcOMlo3sgxruSRMJLBBeC
        F3/d8nqKyPxPDlfLXncdnPPgZSOcrbY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=OecV6gEzkWN5e1WerUgpDBIBDyqRf7tuFxLChH5uB
        Yw=; b=xcBo9jroejYl8mY6mIa9PIgLuAH3RJdgrcsr2nV4iOi+SHHA1aZs/DVFe
        fFlC+RJ7IT+NJe9dKor3usAYDLK0TVVWxJE7xk0QQbK8yluzb1UIUBHnqX3thZYq
        Ek8Gva+22OPbe9vQD0OSMgDUv01FitwVXCTtHVcvbs1XFAZqcbc/FNdVqOKbV7cc
        FvTKFkow+I0H9KPAQ5YqFisddeszKwRvAhxoj4S5qDEKinRWVrpm28VU1m+2RBDn
        YoepRMPifEokVPvJKORPI4xae5V1rv/odA9+1q/PMd+1ADiI8wVd2ez+4bTxmvQR
        ltn6qpb94hlx8QRFqjMIY2CS9/JIA==
X-ME-Sender: <xms:8wenXe68nw3GkRUZ3RmkWMRud10T6gs6LbEi2HFXMxFDTvF8HOpmiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeehgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeevhhhrihhs
    thhirghnucfmvghllhhnvghruceotghhrhhishhtihgrnheskhgvlhhlnhgvrhdrmhgvqe
    enucfkphepkeelrdduiedrudehfedrudelieenucfrrghrrghmpehmrghilhhfrhhomhep
    tghhrhhishhtihgrnheskhgvlhhlnhgvrhdrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:8wenXeqV7GIbEj9Bjq-JgNkvIJxa3uAUdV-a7YEU9hbrWWDj8g-t1g>
    <xmx:8wenXfPw1_8JK3KdLDKfLt-vQZ4rDJntqfpROI47BxHplqq3R9Dr_Q>
    <xmx:8wenXW2-jVJmeFlvwns0njsG4-Uk2wGahg6j_v6HVWm1lSBLmSGMYA>
    <xmx:9QenXX1DKwvL2wT8M0aRRGUwtOWvLN9i8a42jzN5bykKjqErZlZ5Qw>
Received: from hanada.local (cable-89-16-153-196.cust.telecolumbus.net [89.16.153.196])
        by mail.messagingengine.com (Postfix) with ESMTPA id 965F8D6006C;
        Wed, 16 Oct 2019 08:07:13 -0400 (EDT)
Message-ID: <94543e4cc5d8474fd1c534d598bcf277df311690.camel@kellner.me>
Subject: Re: [PATCH 2/2] test: verify fdinfo for pidfd of reaped process
From:   Christian Kellner <christian@kellner.me>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Date:   Wed, 16 Oct 2019 14:07:10 +0200
In-Reply-To: <20191015141332.4055-2-christian.brauner@ubuntu.com>
References: <20191015141332.4055-1-christian.brauner@ubuntu.com>
         <20191015141332.4055-2-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2019-10-15 at 16:13 +0200, Christian Brauner wrote:
> Test that the fdinfo field of a pidfd referring to a dead process
> correctly shows Pid: -1 and NSpid: -1.
> 
> Cc: Christian Kellner <christian@kellner.me>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Looks good to me.

Reviewed-by: Christian Kellner <christian@kellner.me>



