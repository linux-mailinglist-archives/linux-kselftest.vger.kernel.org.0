Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EEE4B5A8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 20:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiBNTbt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 14:31:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiBNTbq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 14:31:46 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6E6112A
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 11:31:29 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so112032pjm.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 11:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B3WRB1YL+L5+JbxjEZnwA++AmlGgE13EuGL+PRtHx8Q=;
        b=AG59o1FvNvGvpQjnEKK7YIua4+FGo7zkXCx11iAZy3iRr1cIHX4gAGKMYtlr+uUtkK
         vQ/XbgHjhIMTeqSRSpp3SphCTkg1b1RZgd7SdlkMgl0tVADRCb97t7zFbMb3q+qwalUh
         5mFP3ayooEfBQKfTTG8fK2M/3Zk7Sn+qMMyZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3WRB1YL+L5+JbxjEZnwA++AmlGgE13EuGL+PRtHx8Q=;
        b=4CqW/A73Ts+GocaXqvyx96W2uLQCuHgp3nQcoWthngGjwcTsEPLbOPavTjfN9iN7ay
         Z27yk9MZlZxGcV/uolelLdid8J3sT/K1A7fRzRNhOnGMcYS/sdR9TLemn7Sh7Dd1BABV
         nZTTrRtOQgWfcpAgx1JYnqN99K/s2m8ABWbiNXA7obI0BXZDmozCRFD2NnISk+O2wBxA
         3v7oqV96a+xA4/c7aD6PfKqJpExbBc+l1TKYY12dr5hE7TPXeNAWnh65g3qeNtZxh5eb
         R7gg0gMwY4qbDT0ohljgZFlqC7X91e61ZjGSuaDc4lf1wRG2ePzHAUUXzhRE8ydPir2O
         BC9w==
X-Gm-Message-State: AOAM530AxpmxP46Kp9TwWZS9qQFzVkKuX3dnHXb+TmaE9yHABWsB66GK
        2vmP4qEwUTZcnahDCIs/OYQxew==
X-Google-Smtp-Source: ABdhPJy+kZEHNiyZXB8hQH3+c79ZYEF67uFWvHkrb/jUovgvh6gYuF9jGI1/GqjQlyBi5+IQy5S5qQ==
X-Received: by 2002:a17:90a:688e:: with SMTP id a14mr132426pjd.63.1644866725061;
        Mon, 14 Feb 2022 11:25:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c4sm25662839pfl.131.2022.02.14.11.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:25:24 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:25:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        sherry.yang@oracle.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] selftests: Use -isystem instead of -I to include
 headers
Message-ID: <202202141125.085DF9BA6@keescook>
References: <20220214160756.3543590-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214160756.3543590-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 14, 2022 at 09:07:56PM +0500, Muhammad Usama Anjum wrote:
> Selftests need kernel headers and glibc for compilation. In compilation
> of selftests, uapi headers from kernel source are used instead of
> default ones while glibc has already been compiled with different header
> files installed in the operating system. So there can be redefination
> warnings from compiler. These warnings can be suppressed by using
> -isystem to include the uapi headers.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
