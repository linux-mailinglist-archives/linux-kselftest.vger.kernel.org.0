Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D6274942
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Sep 2020 21:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIVTfo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Sep 2020 15:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVTfo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Sep 2020 15:35:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F36DC0613D0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:35:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l71so12806007pge.4
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WbYiGPaybdIjvQ+aM1gmKUMUqUqOUcyzK5+y//AWywg=;
        b=MjLMSQU8nw9L29XJQBUOQA7cnbIucyL2U5ZxjCyPh/XbOwj84fwbtj5x/llHbz4aob
         QNV3RWFvNeyZTe1lDagS6+aL1ASK65fKy2uuO0qv5V6fsidZazWrSjffC3Txx4ytRl+G
         W9dD02McVkkz7Gz7D4FXGgmr9BAhOPlJQWLX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WbYiGPaybdIjvQ+aM1gmKUMUqUqOUcyzK5+y//AWywg=;
        b=fJZmb4JlgAjIZLjPY4h9iEKll5AyCM/vGAQknDbxIJRbQInq7FRdL0ihd02PhDDvMi
         PIBWrgw5uavoDjWxuw40S26798uOMbJiuUbFJsYXbz7xknIOoRnNbQ3qtc2I+Z8n5RWg
         Ozrbbp6AaDntbYR5kbsO2/54ovtAxvrVzRqlOjtLjgFKzg5aPZNRUlbm5RNqmXsbgKlU
         cp/8fd8E+9OqozvX3OM1WSXp3hQqCK3bClnO4PDc86RtLrns/r+SNan0Goc1RaXTBWsp
         u56nMx3q+wfAordAsVdeKbzXvomOAxRJA63upYtVHRzz1gitLyBNe8xeKy/twRqpsWGz
         jylQ==
X-Gm-Message-State: AOAM5301rsC5WORAL9P1RLjj7SkriT/10jNeYmjB2w7cXyVoykHgds+j
        Nh1aXVBThJ0tbxfdFTvHfqA0oA==
X-Google-Smtp-Source: ABdhPJy2r619sV8SMosETdDrfCQJYznE5K4cHeHTbz8NixPikPkrRbDPM2oXz9x2mc9uGCSXGUFZXA==
X-Received: by 2002:a17:902:7594:b029:d1:e626:ef9e with SMTP id j20-20020a1709027594b02900d1e626ef9emr6247059pll.67.1600803344016;
        Tue, 22 Sep 2020 12:35:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fu11sm2986040pjb.47.2020.09.22.12.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:35:42 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:35:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 9/9] doc: Document Syscall User Dispatch
Message-ID: <202009221235.50986D9@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-10-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-10-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:47PM -0400, Gabriel Krisman Bertazi wrote:
> Explain the interface, provide some background and security notes.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
