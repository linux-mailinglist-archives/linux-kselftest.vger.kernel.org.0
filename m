Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E737D44486F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 19:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhKCSnC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhKCSnB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 14:43:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203DBC061203
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Nov 2021 11:40:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t38so3270555pfg.12
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Nov 2021 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fnS1heGGb0+muHckszGySqCIwOaFpB98WMOnGGOqVKg=;
        b=mEUUXJmD9IPgrcEV0fG8lr2QecKZsk9r5va8PT/HM3PQC0IP3ZgmcyX98lZFfOJj5/
         aJtbR1VV82hV/qbOtprJNFzANIy0qLQ8xpGjlEfbW9QvAsHFQiUiZnRSNuMq0ac4PSQZ
         0/PfJOwnqMHc30Rq1LXaa4KbNerYBDvAmmIvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fnS1heGGb0+muHckszGySqCIwOaFpB98WMOnGGOqVKg=;
        b=dXezft3WJeMZZCkeFzv+74lHvgc9nbEC8MWu6R9qhxH20AP30rLkP9z0klsxSnjNr4
         BT6pKV2ZkiW8GyWrYiPL4pjK+Tszth+4SWdBQQNZoJ+oqD8TedD7szB+951HOdZUQ1v9
         eBwsOzPJqq0blP5QT/azSKmVdWjwuWDsy0PEKob3PhCTVO6ymfwpPH76/9sDbz0yirb4
         r7OK41TKsRJWbjIgSjObrH8EBcylyaf49+U4rO0l9OkXxV3SRCrpyLCJdK/eeQIEX8zC
         i7ngKPzzVSzGxeFFLkPXQ+JV/iMvMYHKyTHamGID2r/VCOM+VoyNCSz2w6qIkV2LdNsk
         ty1A==
X-Gm-Message-State: AOAM5308szq8QnOUQ2WiblzfuJI9VrJns4G/gZps/g0d6oWhmHR714n5
        hB1hjDGhNMUMmDRq8iFDdGobkA==
X-Google-Smtp-Source: ABdhPJzp+ITq0OXvsRnDmkAnKuQZj8sZcIVhXXsgU0yOJeK6eluHRAzpXUU0NDQsHX7Jsb8XD104Mg==
X-Received: by 2002:a63:3d8f:: with SMTP id k137mr35119137pga.21.1635964824700;
        Wed, 03 Nov 2021 11:40:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm3181541pfp.14.2021.11.03.11.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:40:24 -0700 (PDT)
Date:   Wed, 3 Nov 2021 11:40:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/seccomp: Report event mismatches more
 clearly
Message-ID: <202111031139.80CE97C532@keescook>
References: <20211103163039.2104830-1-keescook@chromium.org>
 <87lf253x1c.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf253x1c.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 03, 2021 at 01:37:51PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > Hi,
> >
> > This expands the seccomp selftests slightly to add additional debug
> > reporting detail and a new "immediate fatal SIGSYS under tracing" test.
> > I expect to be taking these via my seccomp tree.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> I am a little fuzzy on the details but I understand what and why
> you are testing (I broken it).  So this is my 10,000 foot ack.

Thanks! Yeah, and the other tests did catch it, but it was kind of a
"side effect", so I added the specific "direct" case where it can be
seen more clearly.

-- 
Kees Cook
