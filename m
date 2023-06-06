Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5867238B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjFFHRe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjFFHR2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113AEEC;
        Tue,  6 Jun 2023 00:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D962y20PT32aMdprELt2ow7HJAgfMXzWFbDpA8O7M3E/7oByDbBdOBB3nQ6e+htwdtmgnIF3mLwShXf9oI7S4V0euNge85NPKwDBpK/6d9PiPRRAuVIfg//ItkgbLnSIwnI2bfnY951485Izuh1iYI4zjLKr+b9d/4+Lc3DNcepK2MDHwhzNieDvDeArXg3M0TfJchCZQfCMSQKM2Stz2JVx9a83K0Yfi+2HORTo2C1waNs6ohPraaR/GCg7trT6I3EpTXwwuBIfxhsEps90RQPV7Psf0j0WpgSv0GgRbKSlZz3DF6uSDA8BdUYWj8m7+3Q11zQGdYJj4xcWPOmGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s37KNW0wVfL7/v6s3m7Yfh9HIX4qq3S5lut13aXDTUs=;
 b=Xm8MvdsZYy2QsVdpo8q0e1f5VrNywBufgI4WG2GA9LSx2ZbcjU32LXk4q01RNe/4g7J0Nx5YFfaPUAjcoydpNU2SVsFYNveiGglXN88rAMMVw/KExKap9sEN6cskA4mSuD5NjGhT6cg24ks+yi2H88rIZRuiWkBYch7bqR/UqyL30X+2tCwMNkDlIGgfuEfX5PVXLybw0vmuI9C4Ou4gheBkM2fJyQ4hXJuQR4JSVlXb8zYBpo6Sxi80si0FYs463VYQ63DVZ0L5ALsvw7SbtxLuJZrjEnzxa3s8g0uGWzIvcqeutHyPJxVN9Qcfx/X/tJod3zsj92kYC42h8Cd+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s37KNW0wVfL7/v6s3m7Yfh9HIX4qq3S5lut13aXDTUs=;
 b=YdsB19oeka8jAA189tXmvZoljsDDhB5pM3RmfZl7KDbwm02ySwlatVqT/h2VSTOudMsYQXjOCXRMHxjoqSgc+eBI+POb7DhWg8GWbY/P1xMviWAhqoCeQywd3lSgH75m00Wf46kM75VE/1J6Ja1fu1I8kc4qOXY3CCdrwDn4xog+qYgGPorEzWDul6qunWRp6FCO5cYp7sZcMWN9ln+d1Aatw1C1XqzYRyX5Au7qAyhkYeYi7/LjMI12DKdybCmA8qo0Vcu0O7J5nyQuBS6Ujbqg0CaHuTuUOQuWriWWAJCxzECjcTHYla+V+AafSnSaldSEjhhaZlLxweymfcrqmg==
Received: from DS7PR03CA0164.namprd03.prod.outlook.com (2603:10b6:5:3b2::19)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:17:25 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::db) by DS7PR03CA0164.outlook.office365.com
 (2603:10b6:5:3b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 07:17:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:12 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:12 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Muhammad Usama Anjum" <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 10/11] Documentation: kselftest: "make headers" is a prerequisite
Date:   Tue, 6 Jun 2023 00:16:36 -0700
Message-ID: <20230606071637.267103-11-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: eb452bca-fef0-490e-ed66-08db665e13f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPSHPyE5Is7JD0oVWeORYtMfsvUKWXu6xjBuKruTsMoRUFfjrf3qwjNJsaxyLj5Y1fgmaKSS3hUidz9BqLvXC5FYRKwk9DXWkaAWpyvUG82cjcByvGeEPosUqxnh5e4jaZw/BOgbdJKIuH4cnyk7sqyhPgVUsUaSyCnwJpqyL1JtSfK957yXOAIWIQ/quN5z/53GwU4TL3WqtWOpFXoAifFg1Mdgu6Ztya6SRa12AXFxljQQvYWrqmRS0sfWxg0SZH4pfuY2aMutwNa593wATZdnJS4C/RmNPFCgUV39BP477gDruf1NtrZEvuw/BLiIc2CgMnEbQLDNDYpqJ47+QS/Qf9Q+u0czVvV0IFAibJwcBkIrU336R/h6M56+47B5Lx5WybIGQqzTredzEZgHlDNfVQHlB2N9CHPP6r65UOdi3rA1EcsnDRXp0A0GiHYxBeMuQlWAH6fw8yZ4BIAQbWhEkSxh854SuJSaTo1jp7Qj6X8GdD03DNaJQF0WyF/uiQeDjrZxp51sR1TTHlW00wSlmQb46c5gz6r+VM1CId50arUdzKtmm2PfIINHEowtZVA1rTS9+eT8jAEPZqN1zL9EadBOrJeHKkH0zzXiAcS0JWPCpsvqGjUmDHu4o98FAUc8ce5Du/OkprdCqzRnLKR2mdn4JORrYlJIktq6A6SyGuqmbOCld5c6uIJ0NvWxRKkq/Z6gD+MzokyYWAF9GUmW/FIcM4BKr9qQMK2nB4pGhyJycL4LOKG3emiIxvFbT9OV2/SKEZ+xPtL0EDW7iHdORTkVWjtnCsM1qtD3KXk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(40460700003)(40480700001)(478600001)(6916009)(8936002)(8676002)(7416002)(2906002)(36756003)(86362001)(5660300002)(82310400005)(4326008)(316002)(70206006)(70586007)(7636003)(356005)(82740400003)(1076003)(2616005)(41300700001)(26005)(47076005)(36860700001)(83380400001)(186003)(966005)(7696005)(6666004)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:24.9232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb452bca-fef0-490e-ed66-08db665e13f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As per a discussion with Muhammad Usama Anjum [1], the following is how
one is supposed to build selftests:

    make headers && make -C tools/testing/selftests/mm

However, that's not yet documented anywhere. So add it to
Documentation/dev-tools/kselftest.rst .

[1] https://lore.kernel.org/all/bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com/

Cc: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/dev-tools/kselftest.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 12b575b76b20..6e35d042199c 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -36,6 +36,7 @@ Running the selftests (hotplug tests are run in limited mode)
 
 To build the tests::
 
+  $ make headers
   $ make -C tools/testing/selftests
 
 To run the tests::
-- 
2.40.1

