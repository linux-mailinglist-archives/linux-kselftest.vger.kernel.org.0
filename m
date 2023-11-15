Return-Path: <linux-kselftest+bounces-157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509867EC819
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A31C280DBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA073173C;
	Wed, 15 Nov 2023 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B5jNO081"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043ED3172D
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 16:04:58 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E527E181
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 08:04:55 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c603e235d1so1026654166b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700064294; x=1700669094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzZnZquzqfUk+KfrDds9CQaV555iZ1w7ZZ/4IXXyLOU=;
        b=B5jNO081WHszP07ZsBKM1CDWKnvz3FH9mmZUeIJOBeQ4RtSAnsgAlB/4zNCkcM4btj
         yDGuU/TQucx9vY2Jb0NlNiwMLl4aSHjmpEVeUYpX4EA5IB6tvF1LI2LIDmwHGCzJaKYX
         ClTQWQx89VcjPw2bT8IytM4QZ8n5qS0hVIvp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064294; x=1700669094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzZnZquzqfUk+KfrDds9CQaV555iZ1w7ZZ/4IXXyLOU=;
        b=MEfk8e1gQb6bgVsxhWaGd7kcmZ7k+H3ecSW39l7n0iOvmVNxijh02YZiZlUU8mAdaR
         UI1UwKVwJezkXJQsLGwIuTkObjJCGVkeEFyTRWhSjQAnugFHRsRbZlfRPxdBr8Nb5BFa
         ukOprymoy4WsXMmnXroIkU5ZSdrEzqV2n/yDss4jdmwSKhyo/j1z6rtzw77Arsmj+KMa
         +k949LM3q2tNxHE+rJEoEMvTXBsDQSEfS1ysisTiYuLBPC9TK4v1aqEZSgkS3HxRQwpo
         tU0YcjtHuUT4Djpg7Zhpt+K9yNXlDqf6Ls9Zbk1HjVqTxse+81/NQeY6OI3BbYNfqIZk
         Clqw==
X-Gm-Message-State: AOJu0YyEiUaIm6E5IGXYR8rGolqd7J4LAAEREWXC0FrPesFsGD3yyeC4
	alI/yhbkHGpTBXw3DZ0gxVUec6ERYvR0qLoTvYTmoJDh
X-Google-Smtp-Source: AGHT+IGSAvM0xvvb1Ry6PGBnxdRNnOlob3rRCgt8FhYh12ElhEATs0eAeotXCEVo1HYoebHEAXTDQQ==
X-Received: by 2002:a17:907:764f:b0:9e5:2c72:9409 with SMTP id kj15-20020a170907764f00b009e52c729409mr8768976ejc.43.1700064294122;
        Wed, 15 Nov 2023 08:04:54 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id u14-20020a1709064ace00b0099bccb03eadsm7212110ejt.205.2023.11.15.08.04.53
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:04:53 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso10747132a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 08:04:53 -0800 (PST)
X-Received: by 2002:a05:6402:34f:b0:540:7a88:ac7c with SMTP id
 r15-20020a056402034f00b005407a88ac7cmr10183276edw.21.1700064293347; Wed, 15
 Nov 2023 08:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-1-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:04:36 -0500
X-Gmail-Original-Message-ID: <CAHk-=whTqzkep-RFMcr=S8A2bVx5u_Dgk+f2GXFK-e470jkKjA@mail.gmail.com>
Message-ID: <CAHk-=whTqzkep-RFMcr=S8A2bVx5u_Dgk+f2GXFK-e470jkKjA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] iov_iter: kunit: Cleanup, abstraction and more tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
>  (3) Add a function to set up a userspace VM, attach the VM to the kunit
>      testing thread, create an anonymous file, stuff some pages into the
>      file and map the file into the VM to act as a buffer that can be used
>      with UBUF/IOVEC iterators.
>
>      I map an anonymous file with pages attached rather than using MAP_ANON
>      so that I can check the pages obtained from iov_iter_extract_pages()
>      without worrying about them changing due to swap, migrate, etc..
>
>      [?] Is this the best way to do things?  Mirroring execve, it requires
>      a number of extra core symbols to be exported.  Should this be done in
>      the core code?

Do you really need to do this as a kunit test in the kernel itself?

Why not just make it a user-space test as part of tools/testing/selftests?

That's what it smells like to me. You're doing user-level tests, but
you're doing them in the wrong place, so you need to jump through all
these hoops that you really shouldn't.

                Linus

