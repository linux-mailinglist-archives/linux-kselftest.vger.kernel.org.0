Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFBC7371F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjFTQmb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 12:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjFTQma (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 12:42:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00831710;
        Tue, 20 Jun 2023 09:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 812E86131C;
        Tue, 20 Jun 2023 16:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3973C433C8;
        Tue, 20 Jun 2023 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687279347;
        bh=xGO7ZSTqNQ+wuxoAioN5+dW0PlyPgIm2sknw/OCQ8/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uq4oAvbjyqGCsQYwYKam7WXy5pj3VgRmNI5igkZh6brpB2jBFnyeFV2zlJLVkkQsG
         LdElDqc7cMLAZziAJ00+POhANG4mfRPf6HQVSCI4pFs/cFxGQOJDJUw60sMklGLJwY
         81WOw3qMvzPFefkHi7hrRgkhWuk3hXA2n+sYng9gURLPO4hEan6ulYHCgMXyHK5B17
         YONhJ2kQ8QdHZkg1QziYCj01zgiFGsYBUyv2/JCLMZgESNdZd1+vvXgnc+tJrg23nW
         5d0peJBXUszjJgxkakYTR6JYStnvcct1Th/xBPRDRpvwC0aiq78PiuuwUuL97U//PY
         fqOv+F4Me49ZA==
Date:   Tue, 20 Jun 2023 09:42:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Maftei, Alex" <alex.maftei@amd.com>
Cc:     "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net 1/2] selftests/ptp: Add -x option for testing
 PTP_SYS_OFFSET_EXTENDED
Message-ID: <20230620094226.170f7e7b@kernel.org>
In-Reply-To: <BN7PR12MB2835AE60CC3164A47FD21C8BF15FA@BN7PR12MB2835.namprd12.prod.outlook.com>
References: <cover.1686955631.git.alex.maftei@amd.com>
        <e3e14166f0e92065d08a024159e29160b815d2bf.1686955631.git.alex.maftei@amd.com>
        <BN7PR12MB2835AE60CC3164A47FD21C8BF15FA@BN7PR12MB2835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 19 Jun 2023 09:46:33 +0000 Maftei, Alex wrote:
> I see I've accidentally sent an older revision of the patch series, before I've rebased properly and before I used checkpatch.
> I will send the fixed one (and to the correct tree this time) in a v2 series.
> Replying to the first patch because the cover letter did not land in my inbox, somehow.
> I hope this is the right thing to add:
> --
> pw-bot: cr

Eh, didn't work, the bot does a simple == comparison:

https://github.com/kuba-moo/nipa/blob/master/mailbot.py#L294

so "Maftei, Alex" <alex.maftei@amd.com>
vs Alex Maftei <alex.maftei@amd.com>

won't match.
