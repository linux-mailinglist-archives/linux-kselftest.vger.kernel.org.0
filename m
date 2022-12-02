Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269226410CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 23:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiLBWpE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 17:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiLBWpE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 17:45:04 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C325EF88B
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 14:45:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b11so6234068pjp.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 14:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3g7XrbFOHXQF84HyWbDjCgysLpIstvnI1wUbPPgABA=;
        b=At5haCX0bqTar1Hvr2E7GoSlV7BYTAzAoBnBeufNfeWUPuu09XlGeBfDcuw/woFlkY
         MAoYg7cSqqBrvmZIlUR4mg79NpZQB1cl7vF86cvnp0qezdTmFYpkd/qQMQnSfY9IxEe/
         z9DsxCTVoqnv9k7Tp1Bfu6zCgoi/tXo1diHYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3g7XrbFOHXQF84HyWbDjCgysLpIstvnI1wUbPPgABA=;
        b=Sy0VIzmos+junMc/+8eW5oz6m6BmrJMvnC8nibZL0jYHFo+bwyskcNkV9OzeytnLVX
         qwNYs2RU2CZ7oRsyyDPd0dJb3TL7gmzvAJb0bwhfFqiX4gKfpwAkzBVR2tBp2XLqrDpq
         2qk4mlUe7mqlB1xH71ETuAZRVIwknLX4hO++DBSMD6rM3nQAWROxTJPnNs2SDNKu+mGB
         xp3Rjz3pGXvWx1rlxdYgb4NtnonuA1z5Oyr6cncCfyPQsis5mXQ0aT8KppM5o3iVH107
         jWt2p7uxQNdPabUPy0SbUrcb37wFYRa1VO0YEAAbXHkuv1ebWDW0VmxM4veCVu4WXW49
         3OoA==
X-Gm-Message-State: ANoB5pmEvhPtuAS6saZbXsFbn1ReXakRn2YphHzKitwz/QgBYoKfmCCW
        gL78OrLdGPG6xm0nspSOCAvInA==
X-Google-Smtp-Source: AA0mqf7g/vrgrIfaXm/Vy5WBdrTrf3KHzSxktB9dINYAefMkQIEOxE769QQVIaD8W9k87/+oOB4Oew==
X-Received: by 2002:a17:90a:2845:b0:219:396b:75c7 with SMTP id p5-20020a17090a284500b00219396b75c7mr28120993pjf.41.1670021103201;
        Fri, 02 Dec 2022 14:45:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t66-20020a625f45000000b0056abfa74eddsm5749253pfb.147.2022.12.02.14.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:45:02 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:45:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] mm/memfd: add F_SEAL_EXEC
Message-ID: <202212021444.3433C0E5@keescook>
References: <20221202013404.163143-1-jeffxu@google.com>
 <20221202013404.163143-2-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202013404.163143-2-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 02, 2022 at 01:33:59AM +0000, jeffxu@chromium.org wrote:
> From: Daniel Verkamp <dverkamp@chromium.org>
> 
> The new F_SEAL_EXEC flag will prevent modification of the exec bits:
> written as traditional octal mask, 0111, or as named flags, S_IXUSR |
> S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
> any of these bits after the seal is applied will fail with errno EPERM.
> 
> This will preserve the execute bits as they are at the time of sealing,
> so the memfd will become either permanently executable or permanently
> un-executable.
> 
> Co-developed-by: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>

Oh, one note on tag ordering here. Since you're sending it, I would
expect this to read as:

  From: Daniel Verkamp <dverkamp@chromium.org>
  ...
  Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
  Co-developed-by: Jeff Xu <jeffxu@chromium.org>
  Signed-off-by: Jeff Xu <jeffxu@chromium.org>

-- 
Kees Cook
