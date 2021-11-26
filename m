Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA44045F0FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 16:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354267AbhKZPsE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 10:48:04 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58030 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354576AbhKZPqD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 10:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637941369; x=1669477369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Yyd1xhd5UFPVScLX53tcVgS6s7csjjr8e3ZJXvcaHIY=;
  b=hav5sCC/vrNor4vLVd860FFcq/Gr/WcCRBZVDS/Kr1Ppy2OhvCRhtQrI
   gyC4j3kPkqzHjSEn3CSIgWYOOAf7AOMWmTiXwzUErl2uR6aEkzwFA1tjt
   HJkpx8ra8wSwSrcgXMNnW4V+2d3WkA9RQ6k37cVnGvciTrapIgXZWP8Dj
   WnKk2wbccx2k8+wd9qr3UddAdLnlJbNLZBDee9bvNGNptXdkAss1p3Kt3
   +0Dm0SKcXQ9PhRhZ6H6JbCUEvGeICRMJJf7EFZQfsg3+f5RwV0X5Nd8IA
   Hu/kIkoU+L4OUnUZ+CfjXHT4iGefhQAOcBGVanDV5maxzaGytnE5Ou6n8
   g==;
X-IronPort-AV: E=Sophos;i="5.87,266,1631548800"; 
   d="scan'208";a="191541527"
Received: from mail-mw2nam08lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 23:41:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmF2M2JlvW4VmgZz7hbsF+fV4y8cCUz4WqijsGteyXo0bdKi9VqAGNHvwzqGqd1xsd08EbRt/VY5TTdpH9CQnZpXq2iO5mWC0HpQtKvaU0v21yYE8tCv3luBbRP8XuziFXdncrBZ6jMP1LITyGwN/A9/+LjUNs/7BiROoV55Hi8dM8Cc/nvYSnXQhVPfR1D/e1wsqKrsVdMuDbHM1Nw1evELdaNhOAEyetJKo/97lqiNtlahQF5xwHipQ+JmcCT+KjiUmgYxXOzrNT2jOAdzLCyklVZB6UJsoaiNyJAySTDxCBVrSOFcfBWp+RGiUBz/gyk8lx+DKN3AyRxc52Ek5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx1+8DqUGGhGvD1mIGY99MgbH1pE/0dGb3IDvhqS54w=;
 b=Q63FZ2tEE5uq8aOtjGSOOJpP9FsdM0ZD2kpOP3jpq360d2uSuZlYsNCXbAKxlQxqXpp1GxjVzfkfpem9mysXEG89NBoY/LZkIhS3s6BMdWeG3Pd3MkRHlyyPLIC+5j0p53J1gSXGaYzq6lvb4KKXbprlu0DO+SEsn8lgaemRxGnp/TepbNY+w9l6ivOcqcamf6xVmbm3pk1/URuedzcswqvtEHKlo2KvCKiOXSvt2UbqHncknLDQcCBprCCCremwtdLCkWl2IS308zmD53UfnU1ZU/gAM07xDZkok7GUiAhkoBERcutsciAGUHo7Ow0wtg43ULwr75C0ik7txWqJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx1+8DqUGGhGvD1mIGY99MgbH1pE/0dGb3IDvhqS54w=;
 b=xGSPKPMfhLIK0S7l47xDbrj3upFVDUdS04ywu0/WDtgb/ic0QGiSQHpjj7PUrCEY4VVV4e7sdfxJuqHeqITjwGqAwVhF5hPOIo8ZOgMWrZ2i7470pb0T/hxaI9/6bFRZZnXxapS5iG5fpndg8C0A/sWQ1k1JTM73nEiG2FAK22w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8330.namprd04.prod.outlook.com (2603:10b6:303:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Fri, 26 Nov
 2021 15:41:01 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 15:41:01 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 3/4] KVM: selftests: Add EXTRA_CFLAGS in top-level Makefile
Date:   Fri, 26 Nov 2021 21:10:19 +0530
Message-Id: <20211126154020.342924-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126154020.342924-1-anup.patel@wdc.com>
References: <20211126154020.342924-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.118.153) by MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Fri, 26 Nov 2021 15:40:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87cf417a-8310-4d53-1c96-08d9b0f325fe
X-MS-TrafficTypeDiagnostic: CO6PR04MB8330:
X-Microsoft-Antispam-PRVS: <CO6PR04MB83304FAE5930ABD4A6BF58918D639@CO6PR04MB8330.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSOjavi9CgSXDSRu5EG0czTb1ulhajkB/pdNfWhiRhSR2IH6+W+XD/1jviluL+9Bi27YbN1CMSWN1ndinCoDZe0jMQHoW57CUrsGVgX1hz8nIyuIb/WdqFc/8aebrrCmgy3p+D4ureUA0EGTT1Cz4yHDeU3BvDT/OVOEnvkVbnJEBJ9wiRAvXp8h5cfMF/Cy4WqH4WXaO5FQzTPISbd9PRxzKP+fzUKzxfyvN4xR7aYroLNVSU5XOaZtQ3FPif11fTkTA2Oz3i4jWo4tegYP1b9puZbJT2wIsZ4giw9DdnqkfWt/ZqNl2Oik+u+MdaUXFAcCO2Uj/XoQnz887qLFlJGV5KgrilvcI07C3lnXQ6g0LtxzEljYVzAIwqxute7Gh8MmiUKkrWJd2WiU2yPldQsqlwr92+heK+ZxfyOlLyPODsqIpniNfAliCUTDUhO34+nGL/WEeXDeRBLeoY9bF+SquVQzQoFfF85+LwBDhPqOtC8J/AabX0dNR8gKdhsPPZ/QhJyevqifkA5sBij+fmr4K3mTgKcM6XRlNmtCPsNjA81hnl4ljgTDRYUKh6L9/sHHbCUMKUG7GELxVSlkhLvsakpxWrGjKIuGPpJtv80HJb74lNHgA5eOPlM3TvqT3jO33ysbKHY7nOFmbrf7gk23TzzlOyhpPpXnOnHn0nr6jnluijk/FV5xR3MDAXyU8aVa/L2zqdysKH3pUmLoMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(1076003)(54906003)(66946007)(110136005)(38350700002)(82960400001)(26005)(66556008)(186003)(44832011)(83380400001)(316002)(6666004)(4744005)(86362001)(7696005)(956004)(2616005)(7416002)(52116002)(508600001)(2906002)(5660300002)(36756003)(55016003)(8886007)(38100700002)(66476007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gVML5QgT5Om0z7oAlYXmNAFA6UMHL5mKL4kWT6/oK8mG3SAZpI+2Dpfjg2L9?=
 =?us-ascii?Q?fn4IL51J57ZVH6ygF7WXNMKiTDMgDCXznSwk3v4IrB64LhUWGtQ193OrpFO5?=
 =?us-ascii?Q?FPZbw1BH9FX5WPp1sp9Z/ZlIqaQkIHwTTY17zYcbD6Q4Woj1nBR66K7dpaKw?=
 =?us-ascii?Q?l8cA2fud7E3D9azGlJFl2W/rDBqlXPu9QoZh2t0qcv1D6Gh4Wp3L7ZtRuvY5?=
 =?us-ascii?Q?kybqdQzz7C9GSMDMU9uBeIgIzmplTOcw7u6Ubwpvp5nsL94FrBXqkuX08GEY?=
 =?us-ascii?Q?dFqJe/QdxnValeqiwTRjijVq/rIo3BXrIYk0clUT8QEv+V041/IBfdZPRVC4?=
 =?us-ascii?Q?o8UaEAAiAr9EPFwF1L8fjwC5+kOlNXD7o7umZBDmE9NwYHMlH6mp9mIYI87Z?=
 =?us-ascii?Q?o1Wny9iIHl8CoYFDrtrFrRcKUH9drU0kJUjRV7YgbokpHlAxJfQ6BWoikE4x?=
 =?us-ascii?Q?awBhJI/A4zvVkmTyGBKey6DACrk6BmYW/Mt+tvz9aOjp8qDFMjOOAZzm26eX?=
 =?us-ascii?Q?aA/Bafwrm5pta5KQDioRW71atyhUwnPzaT5CT7d9rnIuBOZ5akLXwaIJDcro?=
 =?us-ascii?Q?3JzFOYU8UaDqGPTRyYY6JEvcafDvb+ZzijuMhHFdOfoLkT4J6LiedBQU9+fy?=
 =?us-ascii?Q?KwjhUXnF0uPdldw6iM1BJUda2ReseTRfw5RZ1TdOIzzzzap+Lsn8FYBOPEtl?=
 =?us-ascii?Q?FXEoUWh17WD1EJDvA6qyyKI7CxApdqJATuTGrMOMg5wdELMo0kT8Fs/hewS2?=
 =?us-ascii?Q?7eVYoVr1+Tj2dOJlnE8XNRr2VMhROKPshFTPGMGmjKrD1GFuUv2oXCkOUHsU?=
 =?us-ascii?Q?Tbqzwx/Ism4WfysJz8NjSi0zbcIuVEcepxXMqsLaJCxRDmI4z3FA+VMzBzlH?=
 =?us-ascii?Q?hbc7lxp50WvBsmVleI142gRNki3wxSvUlcF8alwow7OH8IWy9HzPdcjjdNUL?=
 =?us-ascii?Q?GI0zqtgOBlgf1ylEmtm96ZcNHaV6luNfcSvR4rnKDhXniAhYmhZUfvO3LEZj?=
 =?us-ascii?Q?Ac9PFpZSLCtfElZ5n+yEYYoHPvKj5BQPUeD6Di8vmaxHpE6iG6392z3bH8f5?=
 =?us-ascii?Q?ur2E5oEWpCY4NQfBBPDLA8OD/BZgFwakwgx/qTBHUykG0Chc3TV4Hpy9CZcA?=
 =?us-ascii?Q?uExXYPmi2t8sgovNm9B4GzATz2yUs5GDhVQyiqvagpdsrtP1e/meQQbvo3GF?=
 =?us-ascii?Q?JA+ehbB7lM0Q+wkburquoHDb3LHWYQaUXqy14zYFemqubNlWxw+SDRG2sihw?=
 =?us-ascii?Q?nCEMNKy4EV3Ht+TiWEZkpdbU4rgbCXbyrkqoAhNgUtbvsy7PSTIfG/P+bA23?=
 =?us-ascii?Q?/X6oWAFzWg9ZKOt3stNYjPlAxkDyvkkrcetMZUOrkw7LcHHdhMX3cT6gKBKx?=
 =?us-ascii?Q?tLqH4QGcOD1je2amNf53IzTZaaxhUyeQBFjPDmXpXLhwdLXurzg8IdG3W3BJ?=
 =?us-ascii?Q?ROLC0eP+2X6CyfYFGYVHhRAUft+oVp+q2gtN+twoydSvuCUILe+dvf5MLuse?=
 =?us-ascii?Q?rP4V/+n1LB42LMUP7ga3ypcg4+PJTsHGN5GSbMpSJA/1XO1BpP9u+xyZEvi/?=
 =?us-ascii?Q?wDgNoX9dmt6Xi4amJqpsOA9LfbGsv8VUwDP6FTfZWbj2WFnHl2rPHJOfeXPR?=
 =?us-ascii?Q?+uCqOHycXKXNDRI+Jv1B2ck=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cf417a-8310-4d53-1c96-08d9b0f325fe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 15:41:01.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yofpo0voj595fe0991/FtxfdZaOUtCDjvJAxvvdT9iA8QO6XlFr9fPmudAwvpbeqh/1hfAzysZo33oiM0Hi+pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8330
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We add EXTRA_CFLAGS to the common CFLAGS of top-level Makefile
which will allow users to pass additional compile-time flags such
as "-static".

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c4e34717826a..ee6740e9ecdb 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -131,7 +131,7 @@ endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-	-I$(<D) -Iinclude/$(UNAME_M) -I..
+	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS)
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
-- 
2.25.1

