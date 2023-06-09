Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A20729ECB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 17:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbjFIPkb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 11:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbjFIPkW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 11:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B7B30E8;
        Fri,  9 Jun 2023 08:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 240A864F9F;
        Fri,  9 Jun 2023 15:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712AAC433D2;
        Fri,  9 Jun 2023 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325220;
        bh=aWwWVlIdLAswMPtKgr8T82Oc7QOw3fCer0hiAPNuURo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bXLgYqOOBKyDsPHeQFUz36oxicv7EJQ7Bl8AkybdNqwW+TNqqqiTM+iG2wBRysaAf
         OM1wWrGQ/IbIqOpYJBirW5HVrTkX06kPSUxkvVkZda6YErQs5CiGcI3CDX/8NQ54eu
         dYG+kzlhK46m0uh2cEmV19F2vBxtxh3jLJNygT8ok/qsgAoGPj2X8yqPH15jLgrHk+
         zw9Mx0nIDReJqjCOWV+IGDddvlkZ76ia/MSHz3H4C2yxtfCmUQ+9O4zwotoUZhONPB
         iehc+k5zIKelyCHTJiSlGMCshJppSTn9ro82F2vFHC7G+7oAguZSWLnH/5byObphnn
         jOkwE9sqiS4CA==
Date:   Fri, 9 Jun 2023 17:40:15 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2] HID: uclogic: Modular KUnit tests should not depend
 on KUNIT=y
In-Reply-To: <f325bf521f1cdc498dbd48b14191d186bdf7b602.1684854545.git.geert+renesas@glider.be>
Message-ID: <nycvar.YFH.7.76.2306091740080.5716@cbobk.fhfr.pm>
References: <f325bf521f1cdc498dbd48b14191d186bdf7b602.1684854545.git.geert+renesas@glider.be>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 23 May 2023, Geert Uytterhoeven wrote:

> While KUnit tests that cannot be built as a loadable module must depend
> on "KUNIT=y", this is not true for modular tests, where it adds an
> unnecessary limitation.
> 
> Fix this by relaxing the dependency to "KUNIT".
> 
> Fixes: 08809e482a1c44d9 ("HID: uclogic: KUnit best practices and naming conventions")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: José Expósito <jose.exposito89@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

