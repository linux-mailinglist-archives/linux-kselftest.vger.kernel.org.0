Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8249D3B5F30
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jun 2021 15:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhF1Nkd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Jun 2021 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhF1Nka (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Jun 2021 09:40:30 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCEFC061574;
        Mon, 28 Jun 2021 06:38:04 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id j184so27413371qkd.6;
        Mon, 28 Jun 2021 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=yWrLgKEK8bPBcHoI/fkkz+6nVPueHkgXLIuRqJ0nIr8=;
        b=DaJ+8XT3y2Ve271KmtccmRvNKShpVwERsXWENWdzmd97r7x0lv1JpfOAaI6YRbBCRq
         Rp5E5z7ZkS8MOZYfjnZjQZWeyPUYo1zVlgJGVkvUAR4gbDnXbrAq6jzBe2YBTSNKnoan
         axMQfbLlg9RnBwJgSSDFJS1/WtSnQAtLG/soi17iO1+c3XDiJzNw+6rKoRwbXj9tXzHt
         baKBkGxFH3aWIr2kkbhjjTIdYKvTdDNR70HsRVfdHcUhbAtaisF7w20Me4cG+jdQfBr8
         i9ICfQ7xIlbnHCJsgKjfvurgFGc4+6lEKm+rm7qDBARgwfXRtuCDPvCxpRT4v313+6VI
         9fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=yWrLgKEK8bPBcHoI/fkkz+6nVPueHkgXLIuRqJ0nIr8=;
        b=DnJjPOY0Of4gGipnlNExX6fHmFT86IA/y/oDMLd9Lyw9O7q+LNvBAqdjf6SqxfvlGJ
         snrvKoyIIzxPbLVWhGUWYRU5a4yjULp9eH/NxsJGIdpP3JVCkEiPFkwqrZEA2TcP3IW1
         x29zjZtQnfYQWQO73STLxe2Tvrm7Ug25EnPQ3QKgXd9C+NC7ZrDU5EMmPAoRAY7ChgR2
         IGjfKI/DfsqX1FOJmKfhdRnvMdJgbK8LFOn27NZjEzzy5/hvitqDX9VpZYBfv8/SrIJs
         LAHhZpLu6AnGZ3C0Gy4NxIpsGQ+8PQxGCErIgWfWp8HS3iv9E6jSyGVM7FFa2dvW61JP
         q29Q==
X-Gm-Message-State: AOAM530P025nHpI8RJ1USVaAQHSL/olyQ8jtkYdTVtpkI240Epw6hxkj
        /zGz6j6v8CYF6pCX+C/ydtU=
X-Google-Smtp-Source: ABdhPJz3BXbDFy0x6Zijuf0/8TzcBVqfdxc0tf2CqHHXa9eoT2DKQYp5BnlaABJMzGfw45lDrbOqPg==
X-Received: by 2002:ae9:e803:: with SMTP id a3mr9183850qkg.93.1624887484198;
        Mon, 28 Jun 2021 06:38:04 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id r4sm1864189qtn.57.2021.06.28.06.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 06:38:03 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
Cc:     SeongJae Park <sj38.park@gmail.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2] kunit: tool: Assert the version requirement
Date:   Mon, 28 Jun 2021 13:37:59 +0000
Message-Id: <20210628133759.18659-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAGS_qxoPq1f+dcaf43xyjbDhW-ASG3gZez-b0Pv_s17JU3hePw@mail.gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Brendan, could I ask you opinion for this patch?


Thanks,
SeongJae Park

[...]
