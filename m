Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88621102FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 17:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLCQ6B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 11:58:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45593 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCQ6B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 11:58:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so4056610qkl.12
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 08:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGv6wPlEfaDQnYtGOAOevWoaZ+3uby3pI57SYgWQTNI=;
        b=WX4D3wUvamLHUCMd3X7827VO8nkX81yqK6948Lqq5p4ow0mTtHhgLvcCeKfPkOaI7a
         y9SHrhw8qF0DrowXPGDfmW6DwmH7foRrI1rbJ7iBmI9ZLvPZtA2GIf8j4j62DM5YNOqH
         7Mk2Qk639GMCkxuuhkM/ltrjoXLs+puXzkLYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGv6wPlEfaDQnYtGOAOevWoaZ+3uby3pI57SYgWQTNI=;
        b=VLWR8k2VuXc+y0UR/CFDyMtfTpK5Oy51ZXk315hvQZHqInMni9MjJWpYmcE6GC4Ac8
         ly7fD8J6U2yMUUBrF8sZr11aLjB24MKB7NMcl7oql0tlDUxkgEUH/vwP+apOzCT3gQ/F
         bCZwIgdFGsnXGzSQLSebpt7N6rZYOXYuL9oIXbgCavuWY6EsmxF8LeBVZc5qIq7D3EdO
         11Y8Tm30jetgV/KgqO63zeQiQn/xwaail6nGi2uATR0PcQkggBxHc9iBQyH4pz9wjM/U
         B7E8Y4Y9qf0YFnBdy2xISytYOuS2zi2yGKYlhTu+YOcxFs1dr3dSgwlLTh2L0Bw11XFY
         YsNg==
X-Gm-Message-State: APjAAAV3vBGASxA8boEwR/e9PqUbJRcoAChTE/pm1OGCBy05IWfLmDWp
        LfFPcuuyODWbjpKYo6+fA65V0iNBgbPxEg==
X-Google-Smtp-Source: APXvYqz8XQ69dPqeLj+di3xVREf9lkPii5kNusdWFAKcRZBOhzDCl9XcLkNTKRxVZg8kogPEgQqtbg==
X-Received: by 2002:ae9:e710:: with SMTP id m16mr5690391qka.242.1575392279905;
        Tue, 03 Dec 2019 08:57:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:49ea])
        by smtp.gmail.com with ESMTPSA id y11sm902808qtj.81.2019.12.03.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:57:59 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:57:58 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH kselftest-next 1/2] kselftests: memcg: update the oom
 group leaf events test
Message-ID: <20191203165758.GA607734@chrisdown.name>
References: <20191202234212.4134802-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191202234212.4134802-1-guro@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Roman Gushchin writes:
>Commit 9852ae3fe529 ("mm, memcg: consider subtrees in memory.events") made
>memory.events recursive: all events are propagated upwards by the
>tree. It was a change in semantics.
>
>It broke the oom group leaf events test: it assumes that after
>an OOM the oom_kill counter is zero on parent's level.
>
>Let's adjust the test: it should have similar expectations
>for the child and parent levels.
>
>The test passes after this fix.

Thanks! Hopefully b59b1baa will also avoid this going unnoticed in future.

Reviewed-by: Chris Down <chris@chrisdown.name>
