Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCEF62E886
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 23:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiKQWg4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 17:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiKQWgt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 17:36:49 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3117413E27
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 14:36:49 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f3so3418618pgc.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 14:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzxjaMgIMOjXfWpMB80ApPsdYwpsCDcOxiwzYvHvCu4=;
        b=ZHYZNpUxVfiDGowQNb1CDnQs4cHGrMwZNqfghhqahMh8Mvv07tq/5LRfafw1ZiLwU1
         r0L6GhrSWZShLoEPSUuAc1vBZncwAMedR5qz95UaYueRDGqjGAx8iLRq3+X8dAhelCCp
         OOl1bBXjnjIVqS8I9URJIzWKIM8Zd9GjbKxgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzxjaMgIMOjXfWpMB80ApPsdYwpsCDcOxiwzYvHvCu4=;
        b=Th8adzjuwM+qLwBiyt7YcxYYQdtjdMxOwsjYD4+QEyPiZFc+p0KX86C63dCLSngmuM
         8JOoEBXRuzvmiYcqbnNjGyjvxULs3g85eXDlZuPVxR6p6l1vIendRj8oBgipURjOKwYa
         Tn6gn8U+ZxVWfnZSfaaKkUL2AuPELn0CBm0hTtpX7raEUoN0VyNPSZboC37KE3TgPQpm
         7+0GaG0sca775CSmeAaON4Fa9UtRhx9njlqudyGuzKv+dYQjooz6mtvICdaMOkCA47cH
         rNk5InR1Wz3Hzt89FFjPvv+xKyehnbdFZqajbNIssCbOyFzpMFy6LxD8O00DmsiUBp+i
         PayA==
X-Gm-Message-State: ANoB5pkgeyP1GJC03IlmS+5P+6hFVF2spHY2WHKi2Q5VcGs64J2erLTS
        dNiLVO2oM4INHCUM75Fu/LRibt2V8gHuGA==
X-Google-Smtp-Source: AA0mqf5epIfzcHBmQUbt0BsdnlmnSQKPd4mxoFUtFeE8Bv9qky6rSGYeOgNrEMx3X5Wo+zC7MiqFwQ==
X-Received: by 2002:a63:1942:0:b0:46f:7b0d:3602 with SMTP id 2-20020a631942000000b0046f7b0d3602mr4013115pgz.143.1668724608592;
        Thu, 17 Nov 2022 14:36:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902710300b001708c4ebbaesm1790244pll.309.2022.11.17.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:36:48 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:36:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] Documentation: dev-tools: Clarify requirements for
 result description
Message-ID: <202211171436.41DCC9F@keescook>
References: <20221117104636.639889-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117104636.639889-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 17, 2022 at 10:46:36AM +0000, Mark Brown wrote:
> Currently the KTAP specification says that a test result line is
> 
>   <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
> 
> and the description of a test can be "any sequence of words
> (can't include #)" which specifies that there may be more than
> one word but does not specify anything other than those words
> which might be used to separate the words which probably isn't
> what we want.  Given that practically we have tests using a range
> of separators for words including combinations of spaces and
> combinations of other symbols like underscores or punctuation
> let's just clarify that the description can contain any character
> other than # (marking the start of the directive/diagnostic) or
> newline (marking the end of this test result).
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
