Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4654A7E2670
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 15:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjKFOR7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 09:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFOR6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 09:17:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6AB8
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Nov 2023 06:17:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE90BC433C8;
        Mon,  6 Nov 2023 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699280276;
        bh=Bii1bXrqmHwI1SYungI9Wd3o6OPm6XsZd+38jSNxrBs=;
        h=Date:From:To:Subject:From;
        b=fvbwma4bJ961d0LdpBl/H0gUkusN4LCu8eAYFncO1QrZNGFkoh8HpUt/4L5Z2Tqqn
         9ctlTE5PT7lLirL17sie53mMsVuZHvtYm9dH3pUyv4We4R+vVDf7OlQMkKcD//+omk
         z6ZFouTsUTwc7HZ6a4uZYyB0gaH/gjY9XQHFvTgo=
Date:   Mon, 6 Nov 2023 09:17:54 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-kselftest@vger.kernel.org
Subject: PSA: migrating linux-kselftest to new vger infrastructure
Message-ID: <20231106-brawny-upbeat-newt-d9fb8c@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Good day!

I plan to migrate the linux-kselftest@vger.kernel.org list to the new
infrastructure this week. We're still doing it list-by-list to make sure that
we don't run into scaling issues with the new infra.

The migration will be performed live and should not require any downtime.
There will be no changes to how anyone interacts with the list after
migration is completed, so no action is required on anyone's part.

Please let me know if you have any concerns.

Best wishes,
-K
