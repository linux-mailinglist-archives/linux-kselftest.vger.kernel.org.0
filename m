Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457DA57FBE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jul 2022 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiGYI6Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jul 2022 04:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiGYI6X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jul 2022 04:58:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C85AFDB;
        Mon, 25 Jul 2022 01:58:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y15so9793443plp.10;
        Mon, 25 Jul 2022 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=shwf/ZtiVJnvPZWHxnuYE0ISBPmDCrahbQbLNftmDFM=;
        b=CkV1cZno9YGzTmLbeNidquqMj03d/icBOtSPSNDSDFGJFib/moEmO5AnYcNGgDkFZ2
         WYQt3Xtvpr3Tiwzfby7nzXsCA4zrPvx5zcQTF3tDY5NBYNNjPz0sAeuVMdii9va62ssq
         jDVqg/tESj3bVduulDXTJ+NAOgB6Z7H7RnN8dRG/jE+LyE6l/gs3k9ICpM/5VQ38I9pO
         gSWi0DdSBFCyUJi4WgzsPx0QczISQrsRaciIhCLkgN1e1SUYcjH1HK1ho9KZuNM1yCyK
         iH9plxelVRxS35xc89WdOy+IgYqWss3fRgLrvpyDeu3LAdXXfDmfIVexs3CyujzXwjVE
         R0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=shwf/ZtiVJnvPZWHxnuYE0ISBPmDCrahbQbLNftmDFM=;
        b=BzD9hEUXj8gnBkj//YbU6rgeXIzb2+Keldw8VMDg3AfoNz1CSmUpYsexRBRS3UVwLE
         IpHnrB4cENLLPYX951lh6ApG5Rp+9QGcJy2yv4KKtKDxZKGn/yHy0oZDS1GwI/bt010R
         0bb9CFXMLoraXTQngpV8rFW2SwYv+cLH+B1nG/KyPjExwtqO1wgCTSlWffp4sVpcmjgu
         ZjZX6/EphxBLBROEQRbOqJb/Byi1SnFb3Ka4itB8ryVWVUZNdf1f2SNl/9335D+nWItV
         kbYZ0y+oW0sc3txQhqtQbsfJbWp9iXWmoTH85TQhAneJrHOX2iGBtfWpLCoer62PQZOP
         3gcg==
X-Gm-Message-State: AJIora9CQIFx20zUhifddegGHWjlCbeVkRI0E1T5d674QiYyWzaYZcOh
        jsjOtwLTMl5+DVVD+W4Eijs=
X-Google-Smtp-Source: AGRyM1tc/EXSEE4DsdivoNyAzDfy9GtqMEsS8v4emW33dXRa/YCFvSFHsQxyYstWK5KoNjJxwZWQ6Q==
X-Received: by 2002:a17:90a:4e05:b0:1ec:8de4:1dd5 with SMTP id n5-20020a17090a4e0500b001ec8de41dd5mr13038394pjh.242.1658739500927;
        Mon, 25 Jul 2022 01:58:20 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a14c400b001f218ddd5e2sm10428560pja.32.2022.07.25.01.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 01:58:20 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0092D104BA3; Mon, 25 Jul 2022 15:58:16 +0700 (WIB)
Date:   Mon, 25 Jul 2022 15:58:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net, mairacanal@riseup.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: kunit: Add CLI args for kunit_tool
Message-ID: <Yt5bKOfUms4e5PWu@debian.me>
References: <20220724184758.1723925-1-sadiyakazi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220724184758.1723925-1-sadiyakazi@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 24, 2022 at 06:47:59PM +0000, Sadiya Kazi wrote:
> Run_wrapper.rst was missing some command line arguments. Added
> additional args in the file.
> 
Hi Sadiya,

The patch description looks awkward. Better say:
"Many kunit_tool common command line arguments are missing from the
documentation. Document them."


> +- ``--kconfig_add``: Specifies additional configuration options to be
> +  appended to the ``.kunitconfig`` file. For example:
> +  .. code-block::
> +	./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
> +

Above generated new warning:

Documentation/dev-tools/kunit/run_wrapper.rst:262: WARNING: Unexpected indentation.

I have applied the fixup:

---- >8 ----

From cd4cf7c5bb2a7bfe3b006d7859e84de0814d7af4 Mon Sep 17 00:00:00 2001
From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Mon, 25 Jul 2022 15:54:24 +0700
Subject: [PATCH] fixup for "Documentation: kunit: Add CLI args for kunit_tool"

Pad --kconfig_add code block with blank line

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 479d16d1f17d60..d19a1b0d58595b 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -258,7 +258,9 @@ command line arguments:
 
 - ``--kconfig_add``: Specifies additional configuration options to be
   appended to the ``.kunitconfig`` file. For example:
+
   .. code-block::
+
 	./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
 
 - ``--arch``: Runs tests on the specified architecture. The architecture
-- 

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
