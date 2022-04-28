Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2D5134B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiD1NUB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Apr 2022 09:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiD1NTZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Apr 2022 09:19:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545753B57C;
        Thu, 28 Apr 2022 06:15:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D93E35C0107;
        Thu, 28 Apr 2022 09:15:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Apr 2022 09:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651151753; x=1651238153; bh=zddeKWyxC/
        TAt6LDXLxofwc+G7l0sx6z+g7NouKJEpY=; b=XmJyvgZYy9VnIeFSXqe6ON9sGj
        SUWWb886ONya30ixz9byMgApEglKBPm2RzI4wRIyyDHRJAYzRvTgayuzQAikeQCT
        3ngIKtsePx99rDKawU9bPkVOboVNdQNJTBaiqgWWQPeGGd5oPXjIQVakIL1qf8Zd
        HM4lc180HPJZZWGNfYOZTjt4+TBYo/OjaESZ83VDsk9gVQyBSGinuX/cJsraKsmo
        YkeWN4JBjq2M6/5TkGgipNb1+Y83lL7ljqsWGNIvA/6C+Z6bBqkxp0/dT11+OKyI
        6ur7nL0NOTdvYHB7e0R30wB4b5PjzDUoriYY920qZOMwaBNPlGfWDM/ec+Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651151753; x=
        1651238153; bh=zddeKWyxC/TAt6LDXLxofwc+G7l0sx6z+g7NouKJEpY=; b=I
        gEBqwoihU7BZ0GC2y1S+qih7WZL4iySYd6Qg+QEPbyCiHymKVZekKQQDwAk20QtU
        046UCTfKSLM+cQIsoqrK8Ui2iJQFe1w8C3/K6nL+uaim8aedz+4as+vr5HnnzXSE
        v9VgNFYbfSxtHgyoO4KNXbL5jOcJQ+QMt/j7qr944pDVZOKFgN4kUpQ5cJL5laKV
        cf/epzYtpQ4Tuf+K/GcGcPgGBvqFXd2DEs2dPX0eo3qhq0zt6Fk0+cviLS1yhxni
        p+uFOrhzJU0Gsy2tzXwsrybH8RIUVF6tWC9gb5K+a8BuZ1VhfIkiFemZRKHL+aLz
        tIPzHJlHPvol9KoKkOGjw==
X-ME-Sender: <xms:iZNqYnsck8djimQ7q0MpPtrNAoRB8IpWlTOiEe4qOxeimnetk-8P_w>
    <xme:iZNqYoe-k1ifv5EkVkFRlfE9kq0iO_mEmYO9revuXfscWL9Ej8Cb4kvTdTGKViE7c
    tXBeEq3BnWRW29VvxE>
X-ME-Received: <xmr:iZNqYqzB6SFiJmfaaiK3uhvNMGNZNKpKrYQPkiyBZyQSFZ_NcS-SlP2WQZSyzxALHwjrnNI3aKDRfgFHaBi72hOR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:iZNqYmNq-2vE8UUCLTpL2OvGwnubSLvczaJDzmvQgnovSyqNE7mdHA>
    <xmx:iZNqYn8CKQWBEdncV90Wbp_-ggI3LgvYZxn1axOkzEOHODlgp2o3wg>
    <xmx:iZNqYmXGrvrSPfFMI93d2y5R3_rkmurLi2QYM_GT2dS-R5zpMCixRg>
    <xmx:iZNqYjZBvEBluG1458zOcDPFysaGXOZa-9fD53_-ZPqcquyg-jfG8g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Apr 2022 09:15:52 -0400 (EDT)
Date:   Thu, 28 Apr 2022 07:15:51 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/seccomp: Ensure that notifications come in
 FIFO order
Message-ID: <YmqTh68UkjVsTnUX@cisco>
References: <20220428015447.13661-1-sargun@sargun.me>
 <20220428015447.13661-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428015447.13661-2-sargun@sargun.me>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 27, 2022 at 06:54:47PM -0700, Sargun Dhillon wrote:
> +	/* Start children, and them generate notifications */
                           ^^ - they maybe?

> +	for (i = 0; i < ARRAY_SIZE(pids); i++) {
> +		pid = fork();
> +		if (pid == 0) {
> +			ret = syscall(__NR_getppid);
> +			exit(ret != USER_NOTIF_MAGIC);
> +		}
> +		pids[i] = pid;
> +	}
> +
> +	/* This spins until all of the children are sleeping */
> +restart_wait:
> +	for (i = 0; i < ARRAY_SIZE(pids); i++) {
> +		if (get_proc_stat(pids[i]) != 'S') {
> +			nanosleep(&delay, NULL);
> +			goto restart_wait;
> +		}
> +	}

I wonder if we should/can combine this loop with the previous one, and
wait for the child to sleep in getppid() before we fork the next one.
Otherwise isn't racy in the case that your loop continues to the next
iteration before the child processes are scheduled, so things might be
out of order? Maybe I'm missing something.

In any case, this change seems reasonable to me.

Tycho
