Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428DB65B4F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 17:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjABQQm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 11:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjABQQc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 11:16:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECE91088;
        Mon,  2 Jan 2023 08:16:25 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id co23so26735748wrb.4;
        Mon, 02 Jan 2023 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKIJPYaJSdM3GKsqUf/WtIlPO2sQ0/XB3Crq4Is/cNU=;
        b=pjHG4gCV0CBN4TWnma/ku4nCxrXwnvh5BTC/fjr42Zaw3hXIKmiAoxAn/mykTGPb9K
         yZUfPO5KrY0IN70tJ4dfSEIXVTvHM2WFKZCddKD1Ibnq9BMJKm/lNb+knAOXtvQUcNmK
         eYxAFY6Ju3lIZiACzT4E6SUfEzvRi0momUwjXMcspqmNP/So0K3ju1r9DTBkpx1ecU2r
         UPMOFBzPLsAd/Yne5j1VLJesK7SiXTzXDoaniLpBXnCGv+De11zTYg0flzNlkl1sTUKs
         PdCW+GavwtBTAwMobxuHcLuqrT6M4rziSNuxF+qZ2yXoN/loHysAObx0YgPqPVHA+xLI
         hKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKIJPYaJSdM3GKsqUf/WtIlPO2sQ0/XB3Crq4Is/cNU=;
        b=nqiWD/UR3apGucCxnWxJWUsv3a0uPZMSxH5Iu0rxoesCy19rwnIMnHjVaCpwDddDO1
         fVS0XzGMmkbuGOodweJnXerd1PtN6m3qb16lPuCl18/yX84N3f5J9uw1mIjzlggxr1aX
         B1C0/pqHqBVkV4XZ/tYO6GbckBlogLnuDDqlXshCU0DPDRfjy06PqFI8SQggRrSTemki
         +Xmged/FFkD5GZvujWjtyZVwSSGtZ0UQnamLyRe/HeoSGAUCPC63R9TP3D3TdL8We0Au
         2W9mGef4AqMITyeVc7LieVC6YfII8U2a5684yvDR7hTZ8q7cJzsdfMsp+tHSkgy3r656
         bItQ==
X-Gm-Message-State: AFqh2koWzfCVjbnRQuLGnEUVAOTGflbYcuWiJLhQaOZ+XOMEqYlUYCjm
        6yg0b7ZYSyM/wWn0FTYTQkOFzrsNioU=
X-Google-Smtp-Source: AMrXdXtCovWSnecYarAiFHu4OIRig1uH9TEdmNmBgRP5jhe4tXLG9RYBuwHMpulTDEkbZ1CdO2cREQ==
X-Received: by 2002:a5d:4f83:0:b0:28a:8f13:dee5 with SMTP id d3-20020a5d4f83000000b0028a8f13dee5mr12188409wru.40.1672676183747;
        Mon, 02 Jan 2023 08:16:23 -0800 (PST)
Received: from localhost ([2a01:4c8:469:341:d1e1:a149:58ed:f096])
        by smtp.gmail.com with ESMTPSA id b2-20020adff242000000b0023662245d3csm29275446wrp.95.2023.01.02.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:16:22 -0800 (PST)
Date:   Mon, 2 Jan 2023 16:16:21 +0000
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
Message-ID: <Y7MDVT4dO2pqxJwJ@lucifer>
References: <420e491062db9151504aef5661c8a2d928ef6bd7.1672675224.git.lstoakes@gmail.com>
 <9d13393a-d203-23de-30ae-4d6476a94fd7@redhat.com>
 <Y7MBqfYv54rY48Wi@lucifer>
 <f29b6cb0-d46b-7d89-c8ad-12b9addf8ce8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29b6cb0-d46b-7d89-c8ad-12b9addf8ce8@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 02, 2023 at 05:10:40PM +0100, David Hildenbrand wrote:
> Maybe wait until tomorrow for feedback from others. Make sure to include my
> acked-by.

Too late... I thought Andrew typically added these kind of things himself? As an
Acked-by could be a reply to an unmodified patch for example. Though I guess
it'd save you having to reply to the v4? Anyway sorry, already sent it!

It's sat in the mailing list so others can review further if required, this is a
bank holiday in the UK, and as a part-time contributor (and otherwise distracted
by book work) it is a rare moment to be able to respond to feedback so will tend
to get squashed into evenings/weekends/public holidays :) If people have further
comments I will, of course, respond as + when I can!

Cheers!
