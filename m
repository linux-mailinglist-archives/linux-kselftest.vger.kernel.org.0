Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71B789CED
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 12:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjH0KQP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 06:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjH0KPt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 06:15:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE94E44;
        Sun, 27 Aug 2023 03:15:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so1838324f8f.2;
        Sun, 27 Aug 2023 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693131322; x=1693736122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKRUbUuhJKaIwa3qDyE5pLuTPeYn99sgtOiRmzFrU1o=;
        b=MZyNrK+zky4qPiM7YuIzYBRlUuXPVUlmaKRgMfhThnYq47Y8ZgEawrMIWMia4hy+GD
         7QvwOzwmBddVVPfsHaU9D/y6wOwSYQBybpHv68Mpsnzae4ruR86Q0hr1Yr7mzimyRZTJ
         FVFWgOtjqMUMfa4yKwS6gLnzUX+XO4bLr8EgmWX2tXY1gz3H20YiqvTRh6qN41xPD5dT
         CL3tw9oCEg1TmsKgCglKmSx+KtCUdhbeII4Iv2qd2PxA3E/PIzuK0xGeI0oItDtkOKWr
         RhNGS+DAqGyOKVdLJ4syJWoPOOZ0QbUdIbYQ+FVs2VjZF6bkAT8YehWikZl2JtOcfPzj
         TcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693131322; x=1693736122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKRUbUuhJKaIwa3qDyE5pLuTPeYn99sgtOiRmzFrU1o=;
        b=MbZQkIiBb/tKm2J82z3Mam4rWCRvDeUDqoznjyv+whDQxrU9LtQDoQFzQD60JWZIYt
         Eug9PolwLrKRCxXLZdUbD4+9vt3b+9Q5kcZ18IMNVCsAJoJnm4fcnj4IGElIoDW36JHl
         74EBOzh3Nix/X2XJbTPKa97rFLbLPU/Nr5XIE7OGDft3ouVQWisl/uMAk2zYrajTh0TA
         pKXudUUbotLz9zdozZoqGL/8hiTE53Sgckei/hIW0N3Lbuf8ogwWjJZNMoeaWiRwCghH
         n1k5TgkuNpF++edaqKHs6Q9IfSPjJSoGyD0QUyGXnjEMxiEOwJyvkTqKSa2bXN1bZGQT
         5zwQ==
X-Gm-Message-State: AOJu0Yx75tIGYiyC/smainRhjLiGlyd+ZR7eGpfu6A51Qf7yvV++Ogda
        UZrG05pbN1pa3b+hd06zyGQ=
X-Google-Smtp-Source: AGHT+IEnyudIg3nKBtZiGWQhS9+o2sGjSVBJKjN8yVI0U2TXJjqwP76b4fojHe+sCRqJD3GIgEKUhw==
X-Received: by 2002:adf:dc86:0:b0:317:ef76:b778 with SMTP id r6-20020adfdc86000000b00317ef76b778mr16658985wrj.63.1693131322390;
        Sun, 27 Aug 2023 03:15:22 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5948000000b003143add4396sm7168911wri.22.2023.08.27.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 03:15:21 -0700 (PDT)
Date:   Sun, 27 Aug 2023 11:15:20 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH v5 6/7] selftests: mm: Add a test for remapping within a
 range
Message-ID: <fb429d82-4576-42d7-b51f-7a72f7f8caec@lucifer.local>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-7-joel@joelfernandes.org>
 <08ce8c61-e7a2-417a-a3cc-d20861753ae8@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ce8c61-e7a2-417a-a3cc-d20861753ae8@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 10:57:59AM +0100, Lorenzo Stoakes wrote:
[snip]

> > +/*
> > + * Verify that an mremap within a range does not cause corruption
> > + * of unrelated part of range.
> > + *
> > + * Consider the following range which is 2MB aligned and is
> > + * a part of a larger 10MB range which is not shown. Each
> > + * character is 256KB below making the source and destination

Just noticed, I think you misspeak here, as this test doens't seem to
offset by 256 KiB? That is the strategy for mremap_move_1mb_from_start()
rather than this test so perhaps comment needs to be moved around?

 * 2MB each. The lower case letters are moved (s to d) and the
 * upper case letters are not moved. The below test verifies
 * that the upper case S letters are not corrupted by the
 * adjacent mremap.
 *
 * |DDDDddddSSSSssss|
 */
 static void mremap_move_within_range(char pattern_seed)

[snip]
