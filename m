Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E20647440
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 17:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLHQ2X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 11:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiLHQ1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 11:27:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B21759F
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 08:27:52 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id m4so1992207pls.4
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 08:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xi5AtQfyFKW48QjJgn0om43xglEuZG79fXKABFwHdY=;
        b=Qlvn1asbS9H0M6pbj4GYcRpup/h9WPmeof1nztqCNbhMKm8RAS0jDa5CCsg3gUcAbi
         ho7HoR2Ur1YWXkgGiSjsTAe0whSd3QO0ygYi4ICDq+/Jq1oFCbblQmRc2ZtYuUUcCKiU
         NdwIBmGPa3yyhh0jRMcQ7CY0NToYxjTq+y1tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Xi5AtQfyFKW48QjJgn0om43xglEuZG79fXKABFwHdY=;
        b=nOjMfMNoZC9gBhN65x+8wLFZEZyMkUbGoOYq8Fgmr2gmaniklJrh/+KDa3yF4LZKml
         moJ6Ak+0vIbGHju9SiscZFvgzcaXyaPxcipBz8sks2u3sx4xKvpBO/DD4iS6Sw0v6oPv
         VDN5L6VduE4NJnumulKw3oD1L9pZ5b7a8M4zX16ZIzHrugRh9bVH8vjyHfpzpU3Z3/9N
         HQhGCAXDBs3ogETrbWQCO2kwd1in4+YANNqaRWv9vXKTUf325s/NZk6IBvlkUmHQGZi5
         cbqSO82yVJxmrKRWJYKHbAMYdpwDuowOPm+ic9t+5pwWoxMEj3eddjswDGrahxfUzbiq
         I1Ew==
X-Gm-Message-State: ANoB5pmaKOpj1OqmPZ6pXT9xPSnzS1YeFI58wwMVfy57GqjBK0HCi9jv
        V90qpB6ikSfi7+C25553yIh03w==
X-Google-Smtp-Source: AA0mqf7fZqLHuVFIquWdRmjpZnhk61DqDRvYowefk//oin4IUsgIi0hEKLqMQTZX+sb0URaUEUVg2A==
X-Received: by 2002:a17:90a:c208:b0:219:91a6:2955 with SMTP id e8-20020a17090ac20800b0021991a62955mr29325757pjt.244.1670516872207;
        Thu, 08 Dec 2022 08:27:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 129-20020a621987000000b0056262811c5fsm15535730pfz.59.2022.12.08.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:27:51 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:27:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 4/6] mm/memfd: Add write seals when apply SEAL_EXEC to
 executable memfd
Message-ID: <202212080827.41F083F@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-5-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-5-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:37PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> In order to avoid WX mappings, add F_SEAL_WRITE when apply
> F_SEAL_EXEC to an executable memfd, so W^X from start.
> 
> This implys application need to fill the content of the memfd first,
> after F_SEAL_EXEC is applied, application can no longer modify the
> content of the memfd.
> 
> Typically, application seals the memfd right after writing to it.
> For example:
> 1. memfd_create(MFD_EXEC).
> 2. write() code to the memfd.
> 3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
> 4. call exec() on the memfd.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
