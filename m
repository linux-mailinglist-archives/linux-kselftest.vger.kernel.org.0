Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2B50D4D9
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Apr 2022 21:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiDXTiS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Apr 2022 15:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiDXTiR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Apr 2022 15:38:17 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC0825D5
        for <linux-kselftest@vger.kernel.org>; Sun, 24 Apr 2022 12:35:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k14so11722950pga.0
        for <linux-kselftest@vger.kernel.org>; Sun, 24 Apr 2022 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cCbva5d4cTef7JnnRvcj+uHQQXUpXaA+2xK/VFzMO4w=;
        b=LkVpoRUG75De+9HyDx15Zr4GfiqqMgKd9qwzqES1FhWMMrY8+v5JTEzxsTQCCfk1jL
         K04ggN0TOWJdxqAzCY1Me9wMzWxsuc9QL7sqhmkoI7zBGn8lIOqHrv+u2X8UTJ1pC8jX
         tE5hm2Wlj7q5NBIT2o5vny1y8BdpYUBUgcBimpvOD0YtB7e7S2YA2LmSclOIXdUq9/Wa
         zdqz9bgmcMBM4lB247PUHYAnQYuu18CZ1xTGBnR4y7odqXfhd34vUzc7lXTpACXzaP7u
         d1Gr6APlLxwJTkAWqCCGLl1csIgXX8n3ATxRvJlNivuYagzEXFQNNpOFPw0QfncBtmdH
         PSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=cCbva5d4cTef7JnnRvcj+uHQQXUpXaA+2xK/VFzMO4w=;
        b=yzeveM7YQ4igeXe2YmX+FcT3To3cVMLkBsS3AxW7VmvDONPxr8j56A+iQgD0Ie4Gjt
         uZoQi3x973BBdneIpD8D9fcpjFeI7rBkhcWuzAxsjz36834NhdJX2S17QfZq11IPwOXs
         m4FqzQZyfak4+K+HGG6eriekgd1Y/6xaSuhx4U/TY9zEg8WZmjyf973NfhRAlHOV0zp1
         Fl8bH5/dOh2MHt86kFfiwwMN0RtLSDn0aZBu3UDIy0xh0fETJf4Z5cm0UYcySZ0GRyMq
         wBZc6vyFYoJfPa+dNJw2ktBQJZ2iiO0Bqkwx7ngKCDUEV/ZtdnFwzO3XS89ZpNdqRmmZ
         0UXA==
X-Gm-Message-State: AOAM531WnZtdL+qbU/J/4qbyYW+gbvecemMDHLDzWj7QUwNh8BobO8d6
        zgXvoKiVow1LXsGgnnTM+rLCTg==
X-Google-Smtp-Source: ABdhPJxAgrjUeROv5fCIkxRGxN9Ux15Tld23PamShec+lf7XaV4NluDJ54VcqeoQLkUeWRbRoE962Q==
X-Received: by 2002:a05:6a00:1702:b0:50a:8181:fed7 with SMTP id h2-20020a056a00170200b0050a8181fed7mr15459151pfc.56.1650828914988;
        Sun, 24 Apr 2022 12:35:14 -0700 (PDT)
Received: from [2620:15c:29:204:d4fc:f95c:4d79:861f] ([2620:15c:29:204:d4fc:f95c:4d79:861f])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a734a00b001bf31f7520csm4222344pjs.1.2022.04.24.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 12:35:14 -0700 (PDT)
Date:   Sun, 24 Apr 2022 12:35:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yuanchu Xie <yuanchu@google.com>
cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] selftests/damon: add damon to selftests root
 Makefile
In-Reply-To: <20220418202017.3583638-1-yuanchu@google.com>
Message-ID: <93c3f9b4-7e14-858b-bf6c-23e4f3bec232@google.com>
References: <20220418202017.3583638-1-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 18 Apr 2022, Yuanchu Xie wrote:

> Currently the damon selftests are not built with the rest of the
> selftests. We add damon to the list of targets.
> 
> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Acked-by: David Rientjes <rientjes@google.com>
