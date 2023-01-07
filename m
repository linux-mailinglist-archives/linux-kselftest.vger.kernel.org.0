Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67A660D15
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jan 2023 09:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjAGIu6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Jan 2023 03:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAGIu5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Jan 2023 03:50:57 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDE44C71D;
        Sat,  7 Jan 2023 00:50:56 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so2232107otk.8;
        Sat, 07 Jan 2023 00:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7LADuRwb6ovNl/LfjytZ8zY/PQtuxARdpECOSArb7aQ=;
        b=ZaHhsyqaNnxp6f5YnLXBYAbT3doBNgnA15cfozMxa+7L9lu4gWO0lp3VkYgyQaOYel
         Cfhs7ULl+WN0PN54as3xTJNMrtVkZx0tThmlDHfUrpzR/4YHbYDd2r7IbvjE8NFzL5kl
         U4e1nQavrqzFUqDARk6NziKSvJ9qvRh0D8TlRf8HAkMp13uxw4JnqF6C6jGKDDIrK+c4
         1LxS8TowSJoNh7r3vzdthzvbdpcCnQDdcLG2rvpqpEWvdLzdqqllK+5n4U51Hq42EfOl
         jqPDMWtDq3ntC73Ult6mF9rKsNuKx7mjHUKHBvxhOl4M4FknAfyPNtkhFDLp32I/CX3R
         N85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LADuRwb6ovNl/LfjytZ8zY/PQtuxARdpECOSArb7aQ=;
        b=1ADjCbPnTBYL3kGAgqBPhpr4Jq6i+TBOWHLbw/SPVFcc2HMF9EdVUEtjnHJMVt08ZZ
         DaUsLWizABtXuZCOeWjoYTrHWnjmT8BpWJJ9ctbxB1tYn7Fa+dkRl08KBmEfagJCgVft
         P4EfaIrLtCFjTijfZvwi/mEeQ0uc+IEERX8AbUDZXfA9S8kHY/bGS+CG5j+yKi/sd5rz
         98a0Ber/KbE7GcBu4pvHEr8eCs63hndm04XIISwvh27IhIAn802J7wmnOvbeUasS5Cfc
         g/WQqPgrIQOm/tavQwtUgtJiAEuphFJZm6KORBpNVWyiv2ayKy9QLIVpaTKoyYF4+fUr
         aOSA==
X-Gm-Message-State: AFqh2kqrnrhfeFwyAgv8rwam6gS6jZmhriJHLvEvFn5VFE4l6x++K5/q
        OGLHtzfEYe3FIiW4BVJNitIEHI4PSOq+rg5UW90=
X-Google-Smtp-Source: AMrXdXuCFuhDil9Ij7dbnBVJR9U+yQm8C8Vz9C+2xD+CeZLU6pTLbxQa42maNr6SnEwr4qV+1aWGRhBiU0DBQ0w+WNc=
X-Received: by 2002:a9d:4d05:0:b0:677:2cef:6417 with SMTP id
 n5-20020a9d4d05000000b006772cef6417mr3127074otf.357.1673081455470; Sat, 07
 Jan 2023 00:50:55 -0800 (PST)
MIME-Version: 1.0
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1> <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
 <Y7bg5sxEZDIaGoXK@kroah.com> <Y7dypc4sFcmYlXQQ@ziqianlu-desk2> <Y7kqx5cBCVojq6QJ@kroah.com>
In-Reply-To: <Y7kqx5cBCVojq6QJ@kroah.com>
From:   Pavel Boldin <boldin.pavel@gmail.com>
Date:   Sat, 7 Jan 2023 10:50:44 +0200
Message-ID: <CABohvEPWBHmrRpZcQejTkZ+CYtYCyu6rFMd4doNn_CMk35um+g@mail.gmail.com>
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Igor Seletskiy <i@cloudlinux.com>, Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 07, 2023 at 10:18, Greg KH <gregkh@linuxfoundation.org>:
>
> On Fri, Jan 06, 2023 at 09:00:21AM +0800, Aaron Lu wrote:
> > If you do not trust what I've done is what I've claimed, now the
> > original author Pavel Boldin has given the patch a "LGTM" tag, does that
> > address your concern?
>
> I don't see that anywhere on lore.kernel.org, have a link to it?

LGTM.

Cc: Igor Seletskiy <i@cloudlinux.com>

--
Pavel Boldin

P.S.: Sorry for the mess, gmail app can't send plaintext.
