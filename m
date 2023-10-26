Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992BE7D802B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 12:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjJZKBA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 06:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZKA7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 06:00:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D0191;
        Thu, 26 Oct 2023 03:00:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 10EB86607355;
        Thu, 26 Oct 2023 11:00:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698314454;
        bh=0zvIs54+PRjllX9x3XurRLHuEuegL1M0PLHQ0nYXW18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlIqLy8KEXz7h0a36Mxj4EOtZN0xePqBpeqxfZUuDkaJOh3VO7uCXKdIWLDCUG6Pu
         r3KgbgWbDlAPmrMgbtzHnOWlp2f4S8LM0gPzIMIS0HRAQku2vm5/FZ6xW9vmWK/Cbz
         WVwhQdl7Cj7Nzi/s8+kUbQHea5rX7b8ocZQk09C2PSwzrfaKlJVIB/dCJSimaJrivD
         Im59CpwRflcXRr8PSW7MYdUoyuAgDvozv4PYlK4C953moX7RPvL7v3GOQ42KqMK7I3
         OZFYESqVEStEIeLeJV7RgeNyKCd7suqNZbjtAoDYTe6HkpFy7M7ivWuv9++db/Rm4q
         wQF+VsQLRRPFQ==
From:   Laura Nao <laura.nao@collabora.com>
To:     laura.nao@collabora.com
Cc:     broonie@kernel.org, groeck@chromium.org, kernel@collabora.com,
        kernelci@lists.linux.dev, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, rafael@kernel.org,
        robh+dt@kernel.org, shuah@kernel.org
Subject: Re: [RFC PATCH 0/2]  Add a test to verify device probing on ACPI platforms
Date:   Thu, 26 Oct 2023 12:00:50 +0200
Message-Id: <20231026100050.30704-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230925155806.1812249-1-laura.nao@collabora.com>
References: <20230925155806.1812249-1-laura.nao@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Gentle ping to check if there are any feedback or comments on this series.

Thanks,
Laura
