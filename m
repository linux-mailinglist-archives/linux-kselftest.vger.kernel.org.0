Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7FF7B29F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjI2Asj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 20:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjI2Asi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 20:48:38 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBAA19F
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 17:48:35 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3af603da0f0so1579064b6e.3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695948515; x=1696553315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tylYhPEWtThqOdjkF6waboL48MfnCro3UFLr0GQ9x28=;
        b=UZWIoDN+hcGjhygGewIEpq4xMg4JXHsxf2/LJgBgM8CKcxjZimzaxqSIuI6MObyg8m
         JFr2/ufJrONw4Uy0PSQ6+sX4cdP/kCY8wp1xGlODI3CXdALlFNTlX0ePltCbh1qo0QpG
         N3ikzEyblLtERDrEjKqBp/SYk1OklRwzMu6kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948515; x=1696553315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tylYhPEWtThqOdjkF6waboL48MfnCro3UFLr0GQ9x28=;
        b=YaZ0xO/JvO7l7jupd9JGoLT8tHy3ufq3kUB+DiXcIW4xQrr4okR7fzNq35JowdE/48
         /Oq18/8fyUI6xCChxwqhK/OSHYD7yvDt+kfjsHFAi48bhqCqHjRcYGdRimb/3soYqIm5
         0ZBYiNCBAqpYfKH8RcS31EvaS5m2Bf9gPph5zsOCRBFEz64KMHffw/e67dZBmozBdFIK
         hl4PrcrL84cqOlCWPmZS8IrpltWMJByW2VVXXwT/uTJ8c0Akm9ywYNqhs1Q/7aL+Xops
         Kn7d+dIAPEW/ExW2xESNXTKfBhRmPsfQv5ug7m91EJ+2jQchL4Lsn6aWkF5IESFrrlqK
         9XAQ==
X-Gm-Message-State: AOJu0Yx89+l3+Hop0Jcqba8MaikHn+A0gXE4aW1/R/YKQlKA0BO61Gkw
        cYzspHLYA12+Iv16/q0eYCVtOg==
X-Google-Smtp-Source: AGHT+IEWHpwzSGA33eSq7rADLwnpRwf9x79Yvho2lnmUCGF45oywwNmstL7fJN9k86IblRlfWA/0BA==
X-Received: by 2002:a05:6808:14d5:b0:3a7:36f9:51aa with SMTP id f21-20020a05680814d500b003a736f951aamr3226322oiw.17.1695948515082;
        Thu, 28 Sep 2023 17:48:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b00689f1ce7dacsm14033655pff.23.2023.09.28.17.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:48:34 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:48:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] selftests/exec: Convert execveat test to generate
 KTAP output
Message-ID: <202309281748.7BAE187A@keescook>
References: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
 <20230928-ktap-exec-v1-2-1013a2db0426@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928-ktap-exec-v1-2-1013a2db0426@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 04:38:12PM +0200, Mark Brown wrote:
> Currently the execveat test does not produce KTAP output but rather a
> custom format. This means that we only get a pass/fail for the suite, not
> for each individual test that the suite does. Convert to using the standard
> kselftest output functions which result in KTAP output being generated.
> 
> The main trick with this is that, being an exec() related test, the
> program executes itself and returns specific exit codes to verify
> success meaning that we need to only use the top level kselftest
> header/summary functions when invoked directly rather than when run as
> part of a test.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Yay! More KTAP! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
