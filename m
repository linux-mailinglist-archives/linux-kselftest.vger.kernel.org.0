Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B945660CF4
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jan 2023 09:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjAGISY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Jan 2023 03:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAGISX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Jan 2023 03:18:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6557243D83;
        Sat,  7 Jan 2023 00:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5670606A0;
        Sat,  7 Jan 2023 08:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C968AC433EF;
        Sat,  7 Jan 2023 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673079498;
        bh=xlMaUzyepTFKgxnx6MHHMVyG0I9ArG8xZVtxSfImJtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=04hXZynvlsY+ZFyyY4CJtuLZemYb5t5y//487GKiQaO1KCupFGJWy8xthSfNDIc8p
         Ka1iRe+SkZloqpCU31xpqOCyeb3sOQ6wWlNhOZu6aPiewxW4kyFAEg8kVsdccdm965
         T/Hn9VLBpDyVBkcyJEndE2RnhFZXQ+o2ye5zHHuI=
Date:   Sat, 7 Jan 2023 09:18:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Igor Seletskiy <i@cloudlinux.com>,
        Pavel Boldin <boldin.pavel@gmail.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y7kqx5cBCVojq6QJ@kroah.com>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
 <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
 <Y7bg5sxEZDIaGoXK@kroah.com>
 <Y7dypc4sFcmYlXQQ@ziqianlu-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7dypc4sFcmYlXQQ@ziqianlu-desk2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 06, 2023 at 09:00:21AM +0800, Aaron Lu wrote:
> If you do not trust what I've done is what I've claimed, now the
> original author Pavel Boldin has given the patch a "LGTM" tag, does that
> address your concern?

I don't see that anywhere on lore.kernel.org, have a link to it?

thanks,

greg k-h
