Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B7460FDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Nov 2021 09:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbhK2IRY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 03:17:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2047 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbhK2IPY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 03:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638173527; x=1669709527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Yyd1xhd5UFPVScLX53tcVgS6s7csjjr8e3ZJXvcaHIY=;
  b=eTBwUt0QeHzRVpMClZTEB/1efw5ubItFCHLSIffQTvtgEU6PN9N1qLrS
   /+af4SKbJ/twkB8SOwYDH4HzkGKiNOuQhKWQ5Qpu8v4IANnYfxQKsiGff
   dD40QkZUbonh3GsDc+K2fFgre6m6SyzG4rGM+3qwEP/PrR20UQOyYgpCE
   KjErtpFiLIAKbIundsUumENxd+7G0AeRf+y6oIdAmKCPuo8RhTdseMLAt
   z1riG1NjvsIiLIto7EcPePI7IKJEAWyBykABKVfg/qkgg6UDb/k7cOyUb
   ujV+66EXIXrAosjvUKwvtuxFkzojFeKwmo2iLU63P1e84RoFG+Qk0zAbC
   w==;
X-IronPort-AV: E=Sophos;i="5.87,272,1631548800"; 
   d="scan'208";a="290889305"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 16:10:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqW0btNN8QZJbTyuRUDxBMK5MR/gXGx9ic8JS394xRXTsyVvi1rGxQvEoE2zBaTYUAhI3nkjL4xDgdWhS2hvx2ytpLU3WfRe+iwDRKKNnOpFUb/CnUTMYh4zcl8eZXk1E48ek1z6IwLELGjsls/LBpKZTvC+EoUkYCGlpi2ojP3EwPznkPICbik+dkG1Oq2Dz4aX1gYOh9dgjJNykZg8uiGOul3SNUwhcHRinjBRdTqTkATUURctJrLuO7iq3DkimHU1Fa/lP7O+XWYIQ49gqX4hW4akvsYSoOvsAaFoIjf8oiasePmIqRbrL5QW2Ri+9XA3y7Wb5ZokoA3qWv99Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx1+8DqUGGhGvD1mIGY99MgbH1pE/0dGb3IDvhqS54w=;
 b=DU95UwNFAOY00dLdLTVEkGOu4DLbGHh/OOqr2+Xb2qXyTj2rmNGX6J+NI9eN0+XEAsqJHJEffvJQLzoUXK/HrXIX2L1tjW5WyocRtFXDzRe/QjdBOwTMuKFgT/7t4J7cIN1BvRlWuZRfqw90u7BNuRZOfSjIF3LLAMkksoAoajDssa/PZvV1Fkq37oCeoxPUl26GlyX/RakfM1DAv/MrYDoKLn7tVXWMITcnjiqAPLg0OL35Fq4zskqFY8/MuvKyNq0xsf1l77gQehhSWYfSMLRgzRwZi690MnaGNPB7JJlwko79UnMCWlgld3tP6yHeEgz/TuxoytA0JaPPmvuImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx1+8DqUGGhGvD1mIGY99MgbH1pE/0dGb3IDvhqS54w=;
 b=v66IYSpl2HXOrzFxWmnoA947ZaoCW6/b/vv+LtdF2yDhd+CLrcCFnK8/zbQOL0ShSBC9qYIGXmLyamQNTau1qJEuhAFrbhlmY/vsOqaF9GwRIKRbEf64tXTIu2W1PC17xlvmnajaxunXPg9hD98Jx5M2gCGlU08s/wdOrklFiyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7796.namprd04.prod.outlook.com (2603:10b6:303:13b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 08:10:15 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:10:15 +0000
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
Subject: [PATCH v2 3/4] KVM: selftests: Add EXTRA_CFLAGS in top-level Makefile
Date:   Mon, 29 Nov 2021 13:24:50 +0530
Message-Id: <20211129075451.418122-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129075451.418122-1-anup.patel@wdc.com>
References: <20211129075451.418122-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.167.150.114) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 08:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72f25ff9-5d61-400d-c0c5-08d9b30fac98
X-MS-TrafficTypeDiagnostic: CO6PR04MB7796:
X-Microsoft-Antispam-PRVS: <CO6PR04MB779640FA20CBC6EF339AED448D669@CO6PR04MB7796.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4owlCyS0UWjOAA2iV8WUwiOM9PpYY5xJ0jXPFuBqJroJmYcKdDtT7foVOkXj6ce0gU6gjae88AHNNpHEZr6tcA7qeg6ib/tO12PZwKS5vFE7DXQqyTPOZ0K63V2El53Gb52RX3T88ncLhD8AkKWEXzGGgDrH0NmP1LwBJxrysolu94h1ThQphezhCD7Gh45WKhRfJ9MnwNm4LPtW2LVQA2Di9GzFoq/y31ySEXPc/zIaioab0LwHe8dQCTkw224T4gtoVSH9SyTBEXhujO0C395F8ZG/FqjPDkC7Z4JDXFb6YOhV+7fhn/vV4mgZS8cDTHg92AzfOW0P6DZYEVO+W+4BcWOshQofDED0SHa8pn2aIKW2HuciU2m8Fs972wCZebSytRJN3E254VX7GD3HIvs2hFnxzDhAqkm8APQRbw/forTRJkbq6dnRC1lrL9w9MkFgajLIFaboUXRx32aVVU4D23KXqsEgVxYQTnCnmnP7mz2lt/RqzZ5PLg9yrc1g8kDgv4aMTM3VxY1MEz6Q3YaxB3qZuoC3CSXOL19U1PapOM/bI9QIM2SE+3WamgIwRH3IrUqGV6cFlW0TOn+kgc20AraSeUAdSq4anfeFgTilA8mZfRrGr6WZdrSpHjCUf7fnW4g87g+SxoWsJ/WybFbLcC3f7m5chnbYmTwOBTyNipOX3diHwup9YGefrOuPxA9dpOe1U+5UP6aewM0pYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(2906002)(4744005)(52116002)(66946007)(7416002)(508600001)(54906003)(55016003)(4326008)(36756003)(1076003)(44832011)(956004)(2616005)(8936002)(8676002)(7696005)(186003)(110136005)(316002)(8886007)(66556008)(66476007)(5660300002)(38350700002)(38100700002)(6666004)(82960400001)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KGlZ/FX+5okYQ0CrENzqhf+IbHHk68XNhwzXov3JJhQunv6NXShPz9Bz8Afl?=
 =?us-ascii?Q?RCB3iOm1jYNy1hQHwYXrnOJHkbvu/+rSIVdhkAy7xaIHbRQp3A5M6Q5wJXO1?=
 =?us-ascii?Q?u+eLA/BgQ7qJpyGT4CvwBKEtRP3n0ivOAMVTi/GjjXG7YMoeMz5WfdB2RsDt?=
 =?us-ascii?Q?tfxBUoH+/6Qpk93afAyZlphg3vue2zyzW4j5zkFudod+5bDzG9NqvjF6g07Z?=
 =?us-ascii?Q?YNS1DkyiNWO4m8yk1BGA6wTX55NbHk4Be4xpelzGSwiqgLGQroih3C/JDno2?=
 =?us-ascii?Q?mBwqjbX5L9yGP/RjUMHGbxiKf4eZOAeLXAER9jy1ABBeo5y7PQny3oNlY35B?=
 =?us-ascii?Q?o0/KQBi1Czls/4yJrOTuF1vjLmPXToTdbZ/G9rQ4TqmN4FtKzf+v4HMyGCtm?=
 =?us-ascii?Q?8rEAljx1dPkQG179B9mAVGLWQ6ULme5BKyBXQ8ivz1UJbtBenmfZ5LJ80X/Z?=
 =?us-ascii?Q?4MiNSVdt9Ydkz+sVLtH5rW8pF3zErv3vRMPsWyRdcPe8PAqbQC8VPz2WnHtT?=
 =?us-ascii?Q?81fPhVA5NvqAb3Txyh3JsArRGFaB16j3y8nF/VKj86yWDiqk81l2fvSK/TQn?=
 =?us-ascii?Q?216gcxlFLjCDAYntWyd8z8qgNhijoaCXJaxFGQx/HQrZZ2svx9XIUdTlmEN6?=
 =?us-ascii?Q?+W0Qt+wh6vGvI9ctopcQ0E5Q9qbItsa3DfG/r/WzXviFA5oU2e6SaWN1GUht?=
 =?us-ascii?Q?VCtE6o+2pkLY9AIkZrGNvsI0EzX4MFgPUMnxFAX8fiiHK1ioMC2drA0UKGK6?=
 =?us-ascii?Q?P46dHI5PtLlOAHYhq1g9b2LLD230AYtytrXxxc+6Gdn9QmVnSCsVd2Q+zZgN?=
 =?us-ascii?Q?66ZXWtx6BZcEn8b6Hs7OZaF8NeYyXjrybQx1ZfSz3NbtEMZLok+EQdYUmylD?=
 =?us-ascii?Q?XmLJi7MQ8yuKlxsc6jJrhaHHz1RbWcELBdf7iW+8qsvFHI1aE2C1C12Ro6Fb?=
 =?us-ascii?Q?peulcm113GWaXDQm//JL4ScUTuVgB+4WxVKhpSZQqeDiLXftPweBlRwRstVu?=
 =?us-ascii?Q?LA97EdUFgV+UEuw/isN519SErrW8rBlSeZMKvF8+Yii2IOB9jM1ibBTE93T0?=
 =?us-ascii?Q?EqjwKevHfdWbi4yjgTNqddmzIvA6sajDu/K12JLoojJkNwII8PJB7ujZEVXy?=
 =?us-ascii?Q?jdw4TaRC3cHlKSP3lVyPbkJo6JW0hy7zo3gowALoLt38zKdgkDq9psYzAPlQ?=
 =?us-ascii?Q?FtlYYg20lWufWfMbwTjjhx3KJZS6JWkL+L3CC30Z+cSiBaLEdv8xbF1d6eQb?=
 =?us-ascii?Q?SfQU2/WA8cOuk63P2FjMAawB1gJXhBeqLNEbZBPDod5e2PSbqDcJxJXjI4/I?=
 =?us-ascii?Q?CEoLfCd131SAAzoM4zA1A/KAUsuxD52V3EL6yFj7AQacG5TZEXJsuIpJFbE/?=
 =?us-ascii?Q?oW8lrpY9+Bcjl3QONBzzs03p9ThKk0enPpZFZY+4yYPmOiaE9dJFAHA0jvsZ?=
 =?us-ascii?Q?0oEcNIAxzaZU21fE5zhjkeFPPXwnbkuAtFI1j4j0giLAxZICTVTTHyaoqzqn?=
 =?us-ascii?Q?DLMGmHlHVzap2YWqDKoyjlRne0Cm+JFhl2YLNfoicyrvW4iLOFRT/ZWQH6th?=
 =?us-ascii?Q?g419lJerYmvdp2jUIKR4fRnKu+sbw0LSF3tiFMy1vNUkF5sG8TWhzr2kSOqW?=
 =?us-ascii?Q?A3U1gYLArUwa33jRLEye76E=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f25ff9-5d61-400d-c0c5-08d9b30fac98
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:10:15.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xz16rxQt1oTSHJ9nORlIRXrE+pW2y4+9VGOUapxWucOjOKx1lfcBotQvTDP1UxcK4I+iYFw8RjhDa5/sTHDrmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7796
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

