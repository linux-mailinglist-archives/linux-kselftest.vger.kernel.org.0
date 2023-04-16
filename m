Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737686E3B18
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Apr 2023 20:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjDPSMO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Apr 2023 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDPSMB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Apr 2023 14:12:01 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45151BC9
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Apr 2023 11:11:59 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54f6a796bd0so282701137b3.12
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Apr 2023 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681668719; x=1684260719;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVJOhu0619OErP99xlPd4ihejbaRkAObRsbcnMFMEhQ=;
        b=woSRwUxuBadaYtz8Pla6HnY8OWT2Z6oLbv+IvJWJeFu7vl5IQgCqhJN9QW7j5/A8Ag
         Pnp0Moej9pT7JgW8tudH+yEzBUktIU4ioEkl0OO35HygM0IqCZWiph5WUYaiQP7GNxYE
         BcgYQV664/sYtXJroRKzXsITY7jTTPQUL/KzHaK/Iqz4JWfWRn/u4135QDVlSgHXlz1X
         X2iX0pcLJDn8kw1qlrq0JIqbpLnFN+aGhQn5GjLAP5/+v8T60MHc1c5lS46Ws3JX6Ie2
         SR26zLTEOJMJNoPwgYukr9mQU3OL5Vks7gyt1HG1/eCYMNm7+uGDuWYwkrUYT2b06rn1
         3ZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668719; x=1684260719;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVJOhu0619OErP99xlPd4ihejbaRkAObRsbcnMFMEhQ=;
        b=EN23wS3pNPWrsfyWWQefMJsivCmDnGAY9b5vDD08UDSTkyGJss/QmLDahm5f3bH2+b
         SbTGcO5lQ28HgOKX5TLva3DaCw/o/D1SStOZ4406mxizAUbWF+Db3/wVPCa0gKLTBO70
         3hbBHd1xaSFazYEAfynOGla9S9O0KImrv6WALqRvygR3JR12ZwD4MbXruDqJukjk3wXy
         LOC//vKj/BkuxFyWnOViBv5E9gPkXo5Pt1MFprm1Zgzccux50jy9m5m3kqXfBQ8PCqGJ
         NssW6ofDSup8Omz7lQBnmx30BPNhYTD9tSvO3+VJX+kyP+0C4H4usxfuKovq/TimKCay
         2K2w==
X-Gm-Message-State: AAQBX9d+cB8kQE4C2piWabY2AMvoMn0mrCmMT9DorrqN/j74fO/WeV+o
        Ku3y9imeD7sTa+j4NbmUWSY87w==
X-Google-Smtp-Source: AKy350bXCNF1WdQWBeDDtbhUdV1w3MyrNNNENEJZGG7rSYcaEKYB0vPKGwv0o3fMAWWvdfv66tXB5A==
X-Received: by 2002:a81:6c56:0:b0:551:805d:6f7b with SMTP id h83-20020a816c56000000b00551805d6f7bmr7528281ywc.0.1681668719039;
        Sun, 16 Apr 2023 11:11:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l31-20020a81ad5f000000b00545a0818483sm2636333ywk.19.2023.04.16.11.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 11:11:58 -0700 (PDT)
Date:   Sun, 16 Apr 2023 11:11:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Zi Yan <ziy@nvidia.com>, Zi Yan <zi.yan@sent.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?ISO-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Split a folio to any lower order folios
In-Reply-To: <20230404144727.e613116684dbd65a4b4745c1@linux-foundation.org>
Message-ID: <49ee481e-452f-61c7-2da5-28de2cf3de2@google.com>
References: <20230403201839.4097845-1-zi.yan@sent.com> <20230404144727.e613116684dbd65a4b4745c1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 4 Apr 2023, Andrew Morton wrote:
> On Mon,  3 Apr 2023 16:18:32 -0400 Zi Yan <zi.yan@sent.com> wrote:
> 
> > File folio supports any order and people would like to support flexible orders
> > for anonymous folio[1] too. Currently, split_huge_page() only splits a huge
> > page to order-0 pages, but splitting to orders higher than 0 is also useful.
> > This patchset adds support for splitting a huge page to any lower order pages
> > and uses it during file folio truncate operations.
> 
> This series (and its v1 & v2) don't appear to have much in the way of
> detailed review.  As it's at v3 and has been fairly stable I'll queue
> it up for some testing now, but I do ask that some reviewers go through
> it please.

Andrew, please don't let this series drift into 6.4-rc1.

I've seen a bug or two (I'll point out in response to those patches),
but overall I don't see what the justification for the series is: done
because it could be done, it seems to me, but liable to add surprises.

The cover letter says "splitting to orders higher than 0 is also useful",
but it's not clear why; and the infrastructure provided seems unsuited
to the one use provided - I'll say more on that truncation patch.

Thanks,
Hugh
