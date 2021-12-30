Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3747E4818F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Dec 2021 04:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhL3DaZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 22:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhL3DaY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 22:30:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D06C061574;
        Wed, 29 Dec 2021 19:30:24 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mj19so20207091pjb.3;
        Wed, 29 Dec 2021 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :mime-version:content-transfer-encoding;
        bh=Gy0Q5xGwq5Uuhmk1X6IQ/CwspJtjLZrIpG+7QYLBdEE=;
        b=PKrbPVRw408D6HvLxhV6TfKvibxuPw3M8bmY8GgRScj3HRSVBcPNIGPKc1lIVLO1k9
         sMZee5dkyOQEZsxjnGxyTIuG92/xrrQHofedlVzrxnxGkGT8SMkHbtijLrezOf5FkP0Z
         tFcgnFsD+qnPsvpFIEEYTelgdqTsci2TdXA/Geb1Jsti/DNoljuYiL8T24Iy9ylpTfSE
         lchgWOlsRJiFk7aadoivTAZJWNRLUzknHcuPKuy8HOzSNCaCy11K+yG1MDbUF2D47VtZ
         r9Z7hXipjsnmdplcVBSyDRJtoJtnm4YQhDZWtkhERv5iWj/O5vSknoMiRnWdgN/ZGle+
         g19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:user-agent:date:subject:from:to:cc:message-id
         :thread-topic:mime-version:content-transfer-encoding;
        bh=Gy0Q5xGwq5Uuhmk1X6IQ/CwspJtjLZrIpG+7QYLBdEE=;
        b=X1a+VFjgUndXJ1V6EG9pNVe3WZY5BRAynDAr2Wwn7VDk90+gSjbqyOqGRM/1oLXymg
         6VSTRXi2OB/4pBqvJR7Hf3Zk4ZqdClpBsebT9V/cKYh6L8bwvnP4FGMsVcw/SzI3OQ7L
         BpV3P7D1cIIiEvTjQPVLRONxLeuT5GdqPKq1kWvAGhVvp8Vj3jKm93fzuI+KLdM+gTTr
         Y5S5dokerFD3DFe3v/3SMWJJVTxVvr0uj6QNhY/2xRCX0/8Lqwy2agG0ewxgp2UVL5VS
         7ubAzi0GELhbnCLbTkoJYwhSmhIe7g7uBcpb/y4i/ROI+60veiVPclHVYPWf9XGOWHjM
         L9CA==
X-Gm-Message-State: AOAM530GX/EmZoapdwEc9hfy6HgWCEHVwFiM2Yq2UypbNVUequhwbyeO
        xC5gyQCqy0916DgAvZlmKMlbCVqqfhtJdemh
X-Google-Smtp-Source: ABdhPJwgSkhe2FFJrcw/JiUY+JiLYzo6FZb6ff3FH84FdEe4wVDYb0I5AMML8GlSmQ1ETXmncO7TNw==
X-Received: by 2002:a17:902:82c3:b0:149:9715:21c4 with SMTP id u3-20020a17090282c300b00149971521c4mr8990110plz.157.1640835024214;
        Wed, 29 Dec 2021 19:30:24 -0800 (PST)
Received: from [30.135.82.251] ([23.98.35.75])
        by smtp.gmail.com with ESMTPSA id x31sm26635184pfh.116.2021.12.29.19.30.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Dec 2021 19:30:24 -0800 (PST)
User-Agent: Microsoft-MacOutlook/16.56.21121100
Date:   Thu, 30 Dec 2021 11:30:21 +0800
Subject: [Resource Leak] Missing closing files in
 testing/selftests/timens/procfs.c
From:   Ryan Cai <ycaibb@gmail.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <764C5A0D-30D7-4E76-B284-C868754F8A1C@gmail.com>
Thread-Topic: [Resource Leak] Missing closing files in
 testing/selftests/timens/procfs.c
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Kernel maintainers,
              1. In read_proc_uptime, the file opened at Line 75 may not closed when going to Line 84 and 87.
              Location: https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d3639d4772966/tools/testing/selftests/timens/procfs.c#L75-L87

              Can I send I a patch?

Best,
Ryan


