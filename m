Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7846D02B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjC3LNO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjC3LNJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 07:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B319EDB
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680174736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oYqpg+uZa6tgjrnBGs2tsZwqEVLA3EFw2OD8bhme+dA=;
        b=evy81rGIM3LuFwJuAXGFqF6zrsOK350oFUzcI9dNvdm7icsGymxGqZH8/5g1zS9oKH9uBi
        5GRpzqnsR00/vOyKdOLocZkM98WXFMrFiSzcqMnriqDhFfgHKxnqFlP+YiomoC03iSrsY0
        ZxX5qLm7yH0Wl0KYOCct5sla5926W3k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-qPG4Bkh8NmCGWJNUEOmVgw-1; Thu, 30 Mar 2023 07:12:14 -0400
X-MC-Unique: qPG4Bkh8NmCGWJNUEOmVgw-1
Received: by mail-wr1-f72.google.com with SMTP id d5-20020adfa345000000b002d716fc080fso1938965wrb.22
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 04:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680174734;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYqpg+uZa6tgjrnBGs2tsZwqEVLA3EFw2OD8bhme+dA=;
        b=73bjmh0Rn1N4I19JEWSi3A9ZAShxs+QyBFLJj27V4oB4J8T+yTBEPNpplnhvyI+Ky7
         J9Pnc7GjHcLjyKFMXgP2gBesdp7c1liuD7zBIBnpCZFmsPxvgWjaqXKlecM9VmtHg2Z0
         tbEDhwHCdx2VNgPA2PoipX2vbm7rF6kfZExXuuTWGgCrzvKdEhyN865USDyrqb5M1+4M
         7eUUFGqKEx5ou7BvqeOJxotAMhPSda9cSp6snukx58QvVPvwjcE8qawfzqdJCHaX77yx
         9r5oIahFeI6psNLTFxdUof2x5uRfsRQ4cn6qjc1/lPpxsdSrQKeEIaic3NQ74J46aDkQ
         LOfg==
X-Gm-Message-State: AAQBX9elrNM7ekRbjT41L41lXehmE7ox5X17wHwcybFeuqF1FkXdzVVE
        hEqvi2uAOhrbzvB9OPnIkrIiVcYwdbpyAutiThLYHB2QrVeCm8l+fsV7ik1WmJShtzjRis/7poa
        mMY9yiHnHmSMMHhbkEuZirBIauw0u
X-Received: by 2002:adf:f4c7:0:b0:2ce:ac70:5113 with SMTP id h7-20020adff4c7000000b002ceac705113mr17557463wrp.41.1680174733787;
        Thu, 30 Mar 2023 04:12:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350bnsNEVnBMYqDKqOs+BLR/fboYCbIFeK4GxvvvH5EDwj1dlpauKlszJEHQWcs591307lwwQdA==
X-Received: by 2002:adf:f4c7:0:b0:2ce:ac70:5113 with SMTP id h7-20020adff4c7000000b002ceac705113mr17557441wrp.41.1680174733432;
        Thu, 30 Mar 2023 04:12:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe585000000b002cea9d931e6sm32767201wrm.78.2023.03.30.04.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:12:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2] Input: Add KUnit tests for some of the input core
 helper functions
In-Reply-To: <202303301815.kRKFM3NH-lkp@intel.com>
References: <20230330081831.2291351-1-javierm@redhat.com>
 <202303301815.kRKFM3NH-lkp@intel.com>
Date:   Thu, 30 Mar 2023 13:12:12 +0200
Message-ID: <87a5zufq7n.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

Hello,

[...]

>
> All warnings (new ones prefixed by >>):
>
>    drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore files
>    drivers/gpu/drm/tests/.kunitconfig: warning: ignored by one of the .gitignore files
>    drivers/gpu/drm/vc4/tests/.kunitconfig: warning: ignored by one of the .gitignore files
>    drivers/hid/.kunitconfig: warning: ignored by one of the .gitignore files
>>> drivers/input/tests/.kunitconfig: warning: ignored by one of the .gitignore files

KUnit folks, what should we do about this? I believe the correct thing
here would be for these dot-files to not be ignored by git.

Not only to prevent these reports, but also to avoid the need to add
them using `git add -f`, since is quite error prone and easy to miss.

I was thinking about posting the following patch:

From f1dc1733001682886458c23b676123635bc29da0 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 30 Mar 2023 13:04:42 +0200
Subject: [PATCH] .gitignore: Exclude KUnit config dot-files

There's a rule to ignore all the dot-files (.*) but we want to exclude the
config files used by KUnit (.kunitconfig) since those are usually added to
allow executing test suites without having to enable custom config options.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 70ec6037fa7a..7f86e0837909 100644
--- a/.gitignore
+++ b/.gitignore
@@ -103,6 +103,7 @@ modules.order
 !.get_maintainer.ignore
 !.gitattributes
 !.gitignore
+!.kunitconfig
 !.mailmap
 !.rustfmt.toml
 

base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
-- 
2.40.0

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

