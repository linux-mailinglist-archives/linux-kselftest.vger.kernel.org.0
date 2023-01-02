Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D1065B4CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 17:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjABQJb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 11:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjABQJR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 11:09:17 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E5EB1C4;
        Mon,  2 Jan 2023 08:09:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id az7so2295007wrb.5;
        Mon, 02 Jan 2023 08:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0f6Df5GAHRv63Ek+imSWcwMNsHw4338pqSJLA2YJouo=;
        b=Y1fHHCtPosDd5qpxe1/lQLlPANHFOWJ3BbfB5ks2rVkHSmDmSAPNt4ZH1JrHzJsgJC
         6rje2eLE7x4GkF9XJobFF2tdHGEcwCuFMdRfS1kRMEWhZy2Gc792lXKZ6BNXqHFQL2Eb
         VK130PKrGGwNsc8OvPfmJ/JvF/xtpMitUFBtdHqJT+pQKj5T2ofxP73kOFOewfj4Ee/f
         mmdUYICW3NrIR+ChcYifGTfI9fkKKpf0Sr7XZmccjIAlYSNr16uzOMOvMaw6YISoA1MQ
         /g7rwcxr51KOmg9VXKhPB+Vl4KU32jLfWGh3tlD5yzNbu8p542D4F5MWvs7xyl2D9/xT
         hJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f6Df5GAHRv63Ek+imSWcwMNsHw4338pqSJLA2YJouo=;
        b=Kky5sjaA9GJ+TdaY/PcZuSYQQvb2sLyh2jFFSraIz2L05TzeLivv41eQalH+rDZjjv
         ebUIjeNQLQcNJxg5DGb1BOf9kELV1YwqtDSstG6Ba6If8KN2gEUgXSDseLiWP8DCnzVG
         TD9eWbI9M3u1eUvYqidsvHvSGyNq3Q+m2EazFDTBDhTwCe6Z5exE6rby79HAl7fdh1dZ
         vw9uKMRtzz8s8vHF613hgdUTRSd1skqEZFHKfYgVd6Tyw0I0B+LC27SAMbRlcb+aDL5m
         efeLyoeCZw7yCefp1uWVPUz6meEavcyOqoJ+IB2SEEb0a4fMCdVshXSA13TiM8wJodSK
         EcRw==
X-Gm-Message-State: AFqh2krNari9ZXtXI68jojabQWWX3MjSGHohvsr2uuzS3docAMjkDD7N
        rc+mScoNU2XZAQ5hTcnvDJk=
X-Google-Smtp-Source: AMrXdXsi8RPlPraZsfzVbsmqLj0DC8LkHcsljtZkutjXXPxuT5lClS5XZH2CibGK0Yx1VJv4b6IcqA==
X-Received: by 2002:adf:a15b:0:b0:256:ffcc:49b7 with SMTP id r27-20020adfa15b000000b00256ffcc49b7mr33710333wrr.62.1672675754790;
        Mon, 02 Jan 2023 08:09:14 -0800 (PST)
Received: from localhost ([2a01:4c8:469:341:d1e1:a149:58ed:f096])
        by smtp.gmail.com with ESMTPSA id u3-20020adff883000000b002423edd7e50sm29443498wrp.32.2023.01.02.08.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:09:14 -0800 (PST)
Date:   Mon, 2 Jan 2023 16:09:13 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3] selftest/vm: add mremap expand merge offset test
Message-ID: <Y7MBqfYv54rY48Wi@lucifer>
References: <420e491062db9151504aef5661c8a2d928ef6bd7.1672675224.git.lstoakes@gmail.com>
 <9d13393a-d203-23de-30ae-4d6476a94fd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d13393a-d203-23de-30ae-4d6476a94fd7@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 02, 2023 at 05:03:31PM +0100, David Hildenbrand wrote:

> With the exit() in place, the else branch is implicit and the else can be
> dropped.

Good point, we'll go to a v4 then :) that does neaten things up
actually. Hopefully this should suffice!

Agree with your previous point about tooling by the way, it would be good to
have some more functionality in place that wraps these places where you feel the
need to goto.
