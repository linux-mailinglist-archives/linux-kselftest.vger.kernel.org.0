Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC525EF094
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 10:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbiI2IfW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 04:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiI2IfV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 04:35:21 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C3B301;
        Thu, 29 Sep 2022 01:35:20 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s18so369640ilj.5;
        Thu, 29 Sep 2022 01:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=E5jCIqVqd7pvYDtG0r+uLFgxCDJIxgPYc2lxuyAfNlA=;
        b=ZX02V6lCNRADn+rx87YVjRd6Cz5GeFcNOEhnuU9d55JDk0Sr1DQv/Bd8LdmKdIS0a1
         mAy1Km4LXBQuCckgn+YakE1TriOqkuJNE8IYxwzNFaovgNyJgzDp9j6a1fTXGEcvn81V
         PaLP+qDyFDhGIXlJGrSUxDZI9KbbjPde/ReX5YdwjBDutVaT1tUB6+uZcZHLIQKVScKY
         59C4nT1Eih6xaozyv4u4efDgkCO3363PXp+Rv/ROqLKXgLjRfjxykFREC+XXjRJISZCK
         47e2pVchck0cIc9gYU3PLv9Vg2YM7rG6BMSlumY/YiRza4OyPqnihANIn62sbI8PJLFb
         4cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E5jCIqVqd7pvYDtG0r+uLFgxCDJIxgPYc2lxuyAfNlA=;
        b=e7BYQHiO2QeG9zXxnSg3Vm5obMoG1Om6vMvinLJ/vfPduZ1UKIR+1nuJb4ZvGwincB
         8yo1gkerit7gdLCNAnPNSeykfIPlIz6BWxF8V4IAGIE6xGq3Vb5oAstDwgV2O6+9teMo
         xzb8d8we+Yl3GLhyB9Crkq0ihg/YwOoUQMuPZbpuIncwfY7AEoBMVo+Vs8v7s1fRSK9h
         0JhRZpf17cFW3ITi2pkIsD2ubSikq3vcUHnXEQe2h09Y8f7ydE7j1wGH4txUiIIX6PrB
         SK793CqO7kQFKqQAN7wLIloIrp+Gv8s+QT32xICun9/DFM8A40GszoMl2ZIh/PVO6inO
         pqUA==
X-Gm-Message-State: ACrzQf3gNe8T4H/2sOmXxW5ubAz1o8WR0IGSquVWgavmc38qbfP9mrgZ
        4K06dnPn66NN647P938/iymCQ5TSWy4t6lSIVNc=
X-Google-Smtp-Source: AMsMyM4O0xU7vZmBhDQxjK4qWrV9ddJm0DoD2VN+pbMvC/xEsSpubeMXTMxAQIW+wf+8SAjyJzftLCgRiCVhkwttaWI=
X-Received: by 2002:a05:6e02:6c9:b0:2f6:40e0:ab8d with SMTP id
 p9-20020a056e0206c900b002f640e0ab8dmr1002289ils.259.1664440519705; Thu, 29
 Sep 2022 01:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220928040058.37422-1-khalid.masum.92@gmail.com> <be928578-6453-5cf1-32da-322aebe2cee5@gmail.com>
In-Reply-To: <be928578-6453-5cf1-32da-322aebe2cee5@gmail.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Thu, 29 Sep 2022 14:35:08 +0600
Message-ID: <CAABMjtGkn=WjtC-vrcrwJaEcESBT3PVEZmUjPMsYD_+zdma-aQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Kunit: Use full path to .kunitconfig
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "sadiyakazi@google.com" <sadiyakazi@google.com>,
        David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

Thanks for reviewing. I shall send a v2 with the suggested changes.

Thanks,
 -- Khalid Masum
