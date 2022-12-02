Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604C56410C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 23:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiLBWll (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 17:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiLBWlk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 17:41:40 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B700EE940
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 14:41:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 6so5506538pgm.6
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 14:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPMshK7tVLl5Lle8RoOXHHhv2DXWHlF2R9uHvQRM5Bc=;
        b=merJ+GaoyeIA1krzJpTvcAlWx2q4jrDPmzZsBdSBPsN2auuRted+2l9PmyqmnDRjMX
         GwKijFgomVRFjyD8dqtOB/DijExpw/+dFZMDUTxIDeqZC76u/xiWq5r9t0vylHKYxY8l
         Z7ETLvpzXA2XcSSwRDWGOCSWe5grGDPrOZI9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPMshK7tVLl5Lle8RoOXHHhv2DXWHlF2R9uHvQRM5Bc=;
        b=NiTMC7+LU+np7yLEdw4n6FS/5POT024/IFC5TdJk0P7QuhzqfymjztzsRF6FUl6hY9
         yypt0ArSFJAwtEDS7Mh8KVR/ouCEdFPF4/NVC9h2NWoBrvG7+yAK6SzHAnsFoSiowrma
         R57zSSWeoGxCWSDTzSuL4rDfbMsK1K6LZzQyIm44FtOfb96+XsQXDay6d+aPJbQPnuOZ
         ARce/klcEimSj6oHw2jbV4DrIYREK1DBVUvSjTshFGPbvQl4i/+++juMpJ/2hIyyoFRE
         QOZhfz9N54dy3Z3DUpaU4DMAoNX6crRkPaX/RftOFXRAG/UTI8W6EMBqP/7u2bUfTH/P
         rm/A==
X-Gm-Message-State: ANoB5pmE60VYvNzXLcWHbYJb2EgEz3sQveKQ6YaWLw37lr28VhiWjmGn
        vR34gLJaJKCOayJ3Xob5CV2GHw==
X-Google-Smtp-Source: AA0mqf4SuLL8KvtdI3fAxn2zB2XRgbdM9yw+U277XBIdZDVunRVgl+uywFPSqtnji0ZuzQi358w7CQ==
X-Received: by 2002:aa7:810e:0:b0:56b:f23a:7854 with SMTP id b14-20020aa7810e000000b0056bf23a7854mr59505812pfi.66.1670020899834;
        Fri, 02 Dec 2022 14:41:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20-20020a63c054000000b00439c6a4e1ccsm4475973pgi.62.2022.12.02.14.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:41:39 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:41:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] mm/memfd: MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212021437.C1FCD63D@keescook>
References: <20221202013404.163143-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202013404.163143-1-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 02, 2022 at 01:33:58AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>

Hi! Thanks for this update! For future versions, please also use "-n"
with "git format-patch" so the patches are numbered, otherwise it's more
difficult to figure out what order they should be applied in, etc.

-- 
Kees Cook
