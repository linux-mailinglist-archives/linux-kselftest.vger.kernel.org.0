Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB28F715C45
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjE3Kw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 06:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjE3Kwz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 06:52:55 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB31893;
        Tue, 30 May 2023 03:52:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B567032009BB;
        Tue, 30 May 2023 06:52:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 May 2023 06:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685443973; x=1685530373; bh=6D
        AjeLvw+wKEwgsFPhuXSaW+FtA9B09IvVBcjDHsLhs=; b=SzxpiHYjP+znZcj7so
        Z7zuEwScbae3+nH65JrfNeoZoaEN4CZa6HWU4qpKwVcdmcGQw1fsCih0VLq3eVu1
        bFxDpEB2P7KL+76wtoP52giLaTm7gFigWOoGfpgVKEgHKCa2VetwRZIyZUfO6mjY
        6jLPT/4VJXrpHfIZaJJ0ZWuMrCnkiSFnW+XY71voBKVFm2+VR2QQ+OWlNrfaxcN1
        c6MkA0CW6SMQdJ8DQrCZyn+vww68auRp9N8yjTWXi98Y5HPkBw2GxqbMbdgFcfdG
        k6HtzaS+BC9mw+YrJtmFzDInN5qshngRilZufAumfygk4e5HsoqCQFqLhK+JZAkS
        p6Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685443973; x=1685530373; bh=6DAjeLvw+wKEw
        gsFPhuXSaW+FtA9B09IvVBcjDHsLhs=; b=CpgMy1TY6ldkyZPtfK/yqn91MRYqp
        i7vDR1vOo7cc3DIoIA/Fw0P8oceSrzdYm9RbnStammq+oR9xGWh8K9oKXNTRo1rH
        +MoxmvqHhF0GfIYntgmazn0ZR0vSB1dDdkI1t0a6lmoqaN4kOFy096dpiw8ZjqgF
        SE7t2D3lDLjtL2tQoanDHAQv6PB3MeruR9ZTR9Ex3kJcqfzbzpyBJbyX3x0W6BwS
        K7Oazm/G/BPtz4Vzta3O3SJeigM3uix218tuDL7I8kwGCAeXDJ+389haZyny2169
        LB3jvu/Be3AVcktJbV/UMcE9f79FtGI9Or9Wkijli0SS0b9NXyYczeOUw==
X-ME-Sender: <xms:hdV1ZFWGv5qQ5bEtfKIjQZQ6VOC-3u4XZSCax5uLtEllmeqT60-Q3Q>
    <xme:hdV1ZFmsjsor_hQPPlgQHSnwaCL30DH6HAO1qAhTJUfXOqz4thymV6w8rqD682tQn
    z5vGhl1cjNOjOrPEBQ>
X-ME-Received: <xmr:hdV1ZBawA3XutzMaQ-Cs16jHn5ZqTyxX4fVUgl9GndZdpidOTTnFi4qq__gcG-EU7zFdnbkp-CvHUx-hpnPbqaLJG3h4To4Z_gdvgPgfiH-6MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhfetjeduffeghfettdfguedtgfdv
    gfeufeduheevheevkeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:hdV1ZIUp8c9MuoXqIr2VsSvlGt0r88ZEoNH45rnA6NcsdX5PjwpxZg>
    <xmx:hdV1ZPnv2w2uywAiDK6KPvcOJUJVpQYyimqiPloJnxzx9ezkGG7NdQ>
    <xmx:hdV1ZFd_sShtAnoHWtzg-9ikDUDcXkQ46hj_SU3qgDJQ-fCX5hGcgw>
    <xmx:hdV1ZKtzlOVdSglq7A1Lc70euJE0LF6ApyBsQ0LPFAKOvXegGYxbEw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 06:52:51 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Kunit: add MODULE_LICENSE to sample code
Date:   Tue, 30 May 2023 19:52:48 +0900
Message-Id: <20230530105248.68238-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sample code has Kconfig for tristate configuration. In the case, it
could be friendly to developers that the code has MODULE_LICENSE, since
the missing MODULE_LICENSE brings error to modpost when the code is built
as loadable kernel module.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 Documentation/dev-tools/kunit/start.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index c736613c9b19..d4f99ef94f71 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -250,6 +250,8 @@ Now we are ready to write the test cases.
 	};
 	kunit_test_suite(misc_example_test_suite);
 
+	MODULE_LICENSE("GPL");
+
 2. Add the following lines to ``drivers/misc/Kconfig``:
 
 .. code-block:: kconfig
-- 
2.39.2

