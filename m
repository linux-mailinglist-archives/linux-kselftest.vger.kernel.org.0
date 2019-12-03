Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F163E112015
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 00:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfLCXMX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 18:12:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40725 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfLCWjy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 17:39:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so2303645pgt.7
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PooeH2U9l4e0abyw2b34fiXdiQuPMqsoVdOri4vyWA8=;
        b=Z4qWuLdzmbQTwgVTPkTffJkS/6pNJFJU52Pv5anld3AdBN2RKrp/QNd1ONA86GCT4X
         Ue7OKCSynqRiSFtptrF3HrNk43XMiXsTQ2B0hgCska6BooFqIZFkPDO2/D24Z9Nquoaa
         wm5Z9A+sS3IkccLQquaDr/DfefHCZZUj9H4vgVMLNNvKvukZfQs7lne9YWKfrNG4zLb9
         EHOyQnKZfLEu0it+urUIkOotHnUuBQSoEytGqEP1moY7TceKQ3RaPVjFaxcxV680ACSY
         cAD51x/PTdUvx4vPH5x/HrR9owsPzsP1j9WGcfG4gxtfx0o31QH3nq6CaIq7UZ+E1KoD
         tfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PooeH2U9l4e0abyw2b34fiXdiQuPMqsoVdOri4vyWA8=;
        b=ESfofIoFl0RCMX5/38zPMKE6Wrp4zHJPS1/0lZBzCQAbr4Eh501c/o/xMVJ8ryJLYB
         1EMBs/WL8RmPgklFGXSN0pKWxkISrlFFGOQp+u1EaemimMAae+iskQ8KHXttEjBZIGzz
         GOnq2TS9xe2p3qOdRaSynYLIge28NhWqBefOXC2xvMIdCryRY1p1L7XtfcUhUzO2Zzzd
         p5QGhnH0v2G0XjHvDSLs3B1i3Ou0UzYgf97GlLgAkbtEPqQTRvTC4Cf0CsFL9peQgFup
         /YaoROfoIs/7v160kJYocYUM5HxXhNQ6Wms7IAXJTwFfYqq2tfGuc+VQ2L79hR2oIoCh
         Qb9A==
X-Gm-Message-State: APjAAAV6MQvU1bQNxzkWGeUHyMs+V3Yv2I8p69Y4rWSl3NIguz8ialkH
        BrXwxgMdbEwGD6GaLIgsY6fiXVCXtuBAmz/+xuVUFQ==
X-Google-Smtp-Source: APXvYqyopdizFtuRaXmHpNZY01aJqLAUpTS7fHYCocl6WpG8VXrtTOu+n9u17wqq8KlX1dRoJ6xGABbIJHbMC+vv96s=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr238999pfg.23.1575412793102;
 Tue, 03 Dec 2019 14:39:53 -0800 (PST)
MIME-Version: 1.0
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com> <1575396508-21480-4-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575396508-21480-4-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 14:39:42 -0800
Message-ID: <CAFd5g47CtpRusO1tit3x+65p8EWVy-PSWU1rhwZ6x6ubbig=rQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] kunit: Create default config in '--build_dir'
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 10:08 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> If both '--build_dir' and '--defconfig' are given, the handling of
> '--defconfig' ignores '--build_dir' option.  This commit modifies the
> behavior to respect '--build_dir' option.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Suggested-by: Brendan Higgins <brendanhiggins@google.com>
> Reported-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
