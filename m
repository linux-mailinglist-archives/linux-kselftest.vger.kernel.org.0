Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ADF6E02EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 02:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDMADi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 20:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDMADh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 20:03:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E66A47;
        Wed, 12 Apr 2023 17:03:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso872648pjb.3;
        Wed, 12 Apr 2023 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681344216; x=1683936216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyutDkp5jrSZUQ7ZSCUPusZLIPe20FEF4eoH9aQqT9U=;
        b=UKlpb+cigpV7szwbL/NVXYViJrjWbFojBNTvxQ7mTTikfFSfcMzWzCQ/O4yLyfeYs9
         WO+FSQoDv/VI5mgMKoG7fwDuIRcyUYxHZFF26GwFjPkzra8QQ2xneaHdJL2UKRZpxLlb
         9VwlEogRmjOA0vS2VLczf4zOgReqgfjKBg75G0sp3ItfvjEtC/YTb0O4vNOK03UxQobZ
         v8aLtuXqZMOaMsvMIa6w5TWdigol1d+Z6H8imco42YqyrD5ZFRFygRubmubuegyjtE0B
         O7tNapemKRqxRL0wgNEJUIPxjiYMC2tJoQnRgCCzywzU7RBEEuJ7YoXOCaWuXqw/WQBL
         jhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681344216; x=1683936216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyutDkp5jrSZUQ7ZSCUPusZLIPe20FEF4eoH9aQqT9U=;
        b=Gr3rTPNsTAKpGH6KiuCpEbCToYSzl6ydcw88MDNHJfiNU1fsZ/0ogS/HTYHexTxRxS
         trzEBM60evVpC0W1YZ292DwUgvfXKdRQbGRU6BQkIUC9AdiaUpslM2XOuCis9OiLFTie
         p+GgxvYe8LCri06ejuYBnnektMlbmWtN9t4X7aO99s4WUIE3lX0ShtKON1gLh9QNLv2r
         tISeaGg9Vj/R2P5lU+kdkrmHkmXzRAiGvYY0UejR77kxcBRhs503eGTyWLJ2wae6UKGW
         o5k0jF0OIqsZ7XuN1lyvWeEkjYIoQCZt21wGAWeOxTU2vdactL5OYntOsgrRNr4qqpuR
         UfKw==
X-Gm-Message-State: AAQBX9dz0kaH3tiol3TI4JozZww+1zEn2+zZLQng6sbt+wfMFXOi3gD1
        qYnpfM4yb+ykroOUYbwpReQ=
X-Google-Smtp-Source: AKy350b5nRy45dcjnYkFzfHskXOi3Lp7CqvWMDpWUw5H2P+CRntPZh1X0IC4T25gVYwBpplY5m91nA==
X-Received: by 2002:a17:902:c40f:b0:1a2:56f4:d369 with SMTP id k15-20020a170902c40f00b001a256f4d369mr142618plk.19.1681344215640;
        Wed, 12 Apr 2023 17:03:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jo10-20020a170903054a00b001a190baea88sm148167plb.97.2023.04.12.17.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:03:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 14:03:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Message-ID: <ZDdG1K0kTETZMTCu@slm.duckdns.org>
References: <20230412153758.3088111-1-longman@redhat.com>
 <ZDcGVebCpyktxyWh@slm.duckdns.org>
 <1ce6a073-e573-0c32-c3d8-f67f3d389a28@redhat.com>
 <ZDcS_yVCgh6g1LoM@slm.duckdns.org>
 <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Wed, Apr 12, 2023 at 04:33:29PM -0400, Waiman Long wrote:
> I think we can. You mean having a new "cpuset.cpus.isolated" cgroupfs file.
> So there will be one in the root cgroup that defines all the isolated CPUs
> one can have. It is then distributed down the hierarchy and can be claimed
> only if a cgroup becomes an "isolated" partition. There will be a slight

Yeah, that seems a lot more congruent with the typical pattern.

> change in the semantics of an "isolated" partition, but I doubt there will
> be much users out there.

I haven't thought through it too hard but what prevents staying compatible
with the current behavior?

> If you are OK with this approach, I can modify my patch series to do that.

Thanks.

-- 
tejun
