Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C8347ECBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 08:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351871AbhLXHgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Dec 2021 02:36:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38742 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351881AbhLXHgu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Dec 2021 02:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640331410; x=1671867410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6rtUJ5hwVZww56rZggFaaJ5G5yuRrZQlGMYZjHbCtB4=;
  b=aWz2qHQ+Y+28wHbwCb3y7UXs2/QzuSfiYZIc8YYUW6ywdQPz2QCulPn4
   /kz1X9FrV/gU/hAb4RuBbw4+FQC3PaX9Wn5NefnHj7gWwKTLJ7spdcZ0D
   jN/RQhi0g15cRw++yhLxtXKISUXsEFkCD7gXVface/KCSYRUSRBVgpGhU
   VpSU8gp85F8M46BDT925Nd2SSmltJxCMe/l5C+/Lh+stHWx1+zWajcbeh
   O3B0z0AAQba5QkVVeY7t/iU/luUq231NVKlEjUHaAIKPPqxbiQl1OJ0Q2
   GPPr2aaldhEY+PWH2zcPMl7xfYuOEnv87PJOuImgPUkQNJERULrOg3JiR
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,231,1635177600"; 
   d="scan'208";a="293035156"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2021 15:36:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFPmUW0dsEcxG9lw/5tD4EdUor5kwUir3qQY9+n5fy94ff69iC+ogLhu1KfNfAYFJVo5gRu+ujF6VEimH7t433vaYvFPsJjbO0J98wbgp3PzLwHghy93noPV06t2O203ZSkiTj1lKjAvHmppUc6qpUKZNo42D8kJSzElSda5A3+E+NHNfRP9aKkVzzKUH5pIt3tjN1iSoTF6UjrlU8krS722hrC19NhrXL60joWdo3G2MFGO/AlkwaWe/P71F3zwN8NnKI1ByHpNN8js8FcBXndYh6QzS0LLmeJQbXJrimfy/3sitepRavNYHveNrMOAj2RPUxq//3JL8jNwDi/hVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2n+RP/1cK2T9Let7nAZvUn8yIwnVsH2pP9tlL6b+QE=;
 b=XbXBOCo9uWl6gLgVOrAqcQW1ApeE1Tt2rCxY85CuKKjL+kAECX7yGHrDZwgMp/Th/bZqcmKHaw//ZM4ROHAw1aYwVqnwq8zao25B6WVbAkOaCl1dQG2oeKgAVh+xXV7LqjReS8TEW07ulirLISk4B8kSVPwozbskv9Hzl/d0AhNgC7pp1sZblm8rXTm8RA8CD1FEMi7PLxzup8D4wXlqWIEtunh4xW47wGMWQDg5m0Hz/PUnJNaifxOpt52qNl+6EdWcLzyX2GeY9xNsruo4OzuItwt+4vgugTWhjCg0bkHDq6deuktSoJ3ykXYahpcQsut/rwSXzsotOdHfrA5sHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2n+RP/1cK2T9Let7nAZvUn8yIwnVsH2pP9tlL6b+QE=;
 b=mGH8CZ6uMvdo7PCYOvAxbN4AlaNj92DOFvudL/Dko+zvHE4QXROivaduTmLig2Ygb3JkGmbW50wlDNhkVEfbCPKq79SojYseS9yZ8ke325APpDj2oCs8gEPQccCeo1ELIkSJq4dbCeepp/gxaHq71+6bOyJ7mBVQyeVLFrF/HHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7859.namprd04.prod.outlook.com (2603:10b6:5:35e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Fri, 24 Dec
 2021 07:36:48 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c%4]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 07:36:48 +0000
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
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v4 3/4] KVM: selftests: Add EXTRA_CFLAGS in top-level Makefile
Date:   Fri, 24 Dec 2021 13:06:03 +0530
Message-Id: <20211224073604.1085464-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224073604.1085464-1-anup.patel@wdc.com>
References: <20211224073604.1085464-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::35) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c4f3e5-211a-4f65-bc69-08d9c6b02497
X-MS-TrafficTypeDiagnostic: CO6PR04MB7859:EE_
X-Microsoft-Antispam-PRVS: <CO6PR04MB78594E4F87E943379C695D458D7F9@CO6PR04MB7859.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAip3TJrXEHLkG+mwEldhLnXJi9WtK/EYLjU4uPlphubQ50vM27e+f7ziyVr3K5MnrpRWSSkYCjswA/3GUG2hl3uKp4IPL7q1lemiVvEdmp+dth5f0CbBPunQxnwk4elZcsG6kTDFQ0cjhoFGD7X1CbmgU8mARgDfvaDRpuXDeyMOBJk83IoieWTKl5DaSk3oLsbmeu726KaCbiajICwMryMZmJeyNQcqdKNAbyCWkAABpLRG+4GxuzxVTqDKB+Sg8Aw7rwuX5l1SLw5w6Xtz1pWRcvRYXNbWIZIe6wS8BzSenb1phIMSwkH6DGYy4wfK5Lu2jeLjwVjjZ/vlWB/PMFcLL4m+KRH6MnUGpmkNcWdHSkdZi3xZ22jPAqT/gtoz5D2fXBjhVIaNPMYrQSkMzF+TdA85vrjbWemovXfxeXiCCE0tLLEAQEFaSbxFfxCgCj+2G3f5oxyGlqk/yvGlldOO6nqFq0kRt8/088cwqC1Wm2txW5zyoEv1F9ocEI4y64bWhYhe0hVjwhiU1b0NnjXzisaDgSEzFdE4rfclwhxSvXoUPAaVZcFNrgdn/vkEo+YbpOtDMQ4IOe7nJHyvSeAOT7QDjlWQ+bxCAsMqZdD744He6wz5LluFNEpjohtEnwsgUlLbqRvj2nHa4RkCMaetlZLCVuRzG9SoasYgUxd2yxrFs3ZuDn3j1WHGcsCnnHYrWaA4N6w6dVOP1OuhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6512007)(7416002)(86362001)(186003)(5660300002)(2616005)(4326008)(82960400001)(8676002)(26005)(44832011)(2906002)(8936002)(6506007)(508600001)(316002)(83380400001)(38100700002)(110136005)(38350700002)(54906003)(6666004)(66946007)(6486002)(66476007)(1076003)(66556008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?58Zs23jbjwV8y65/5f6FLHSGnzEGfCC87yhmoqSIQiq4OPKfy+5WPV9n1ExJ?=
 =?us-ascii?Q?ySFBDroCKk4NInINedYXbydhPvTFSI4QVGnfHjCiVh3c5CkJ85UMPoG0rdVx?=
 =?us-ascii?Q?w2NYsP4FEHtoBLzTtHbus+H3rxZB0HbN27liS/HjjhFUkoBgA3dGJC8NiL1O?=
 =?us-ascii?Q?DIT3QipY4/vMaC62CpLSYsSl2H+5G/d+6+8ce/dXFOH9v8iOA3kzD/13yChB?=
 =?us-ascii?Q?qz5+BNuuUfCjSPC+wd1GAsSwltqAEzrqdWY3ir6Puo+ElGam2FB4/q/Ug8xF?=
 =?us-ascii?Q?+VWy2RpHwvVUoO+7Un32DaPS/ebC9+I1fNbEPXBBTXDOXGzYwoJGKUCT02yT?=
 =?us-ascii?Q?hJjWMHpn5GW1Ii7fyjlWbA8WHq6hXWd+q6Pi8vWHScVpbzVa0EjFTca4V36i?=
 =?us-ascii?Q?OnE7XJatq5XNNTFrpWybiJRpb0VoMEhasoX7urOZ0ZsjErK8/0SABkC0J62+?=
 =?us-ascii?Q?Bow+KeWbdK061MgWVXGhKwAkqRAqOFUE1fNRCs1VnJVf3HAGMA5SjzHAlyRE?=
 =?us-ascii?Q?4y3tzKa6G0uAvspZ+2HK5yqsPppsMKFr96AeqSGKfeujhK4oQqLiaf8Hn+l2?=
 =?us-ascii?Q?lMEUgNdHYh8dK/K0p21WNMGqI9I/NMLv/ue/gOghAqUljj8XsKIS7j2ugHxp?=
 =?us-ascii?Q?f7qnbvHh53AOLYibm5Vs1xJAQmzQ6GhB6/XdCIJ5yJEbYtOCubRf3VaU3G+S?=
 =?us-ascii?Q?XkYVm8Ygeua2xkuvbjd3C/6B1ASdtYDmiMKAX+Ovq34+FRup9sMTm70FPbYV?=
 =?us-ascii?Q?OVK/OyO+gcE9yIGxrlpyzWwdPKF72DHETxVO9w6p4rr/rgszyeJ2tX88qZrL?=
 =?us-ascii?Q?34mQXscXlb6iv7mRinU6xfbYw8JNTnWgVyXQs9T8fONBky6+IeyJYW5y3GM0?=
 =?us-ascii?Q?6llc3XL0Y/go+3yB10rdKeb9KvfvrJ93Hedb9MMqbwt/M0YywwfdbghQ3amH?=
 =?us-ascii?Q?fBqy6V4nANraNmROmDQP0XJwQPuRJamkNHD38zQly0xaEG07dKabtM5JZ3FM?=
 =?us-ascii?Q?i/f7rB1y/66l1KAKjglfrZGU+4XCqRQucrWe4CmX7a8+svl3RtehMXoSnIx5?=
 =?us-ascii?Q?H9pXzi544tP3xxUxZ/51kLDBlv0RSk8DbtffI1gB3zT24rzlnEk6Crk7ZWnL?=
 =?us-ascii?Q?LIPIZBCEBrSm6xqL/C5X2+InIGCBlBljLAPM6mhlhTU4wafGjc57SfAeBzPj?=
 =?us-ascii?Q?RJAEn3vew6f5MjBs2BEkukF/Bs/eJCMqtEy4H6DgbYoYtzo/9CH/HtOlR+w8?=
 =?us-ascii?Q?UFJGEf4Ibt0w1d8NA/oCqFLITpEO75Z4Wa09gNowTKWTvqmI0fWVkjzvHRfM?=
 =?us-ascii?Q?GAQS2Swc44y0plKTOtFT0C6OrfLYL+EM9tCv6mp2CnT27wevrcDui7FlXewH?=
 =?us-ascii?Q?MyO4iEhEkihdpibUw0mMLmmkEi+fKSDdCdY05Iwfv6O+MGVyX5B+0cKmyc54?=
 =?us-ascii?Q?lCn2psvwZZquhIrkGBtkMvk4WzjGAsEs75WsGOUtj8ePaEspbaqT8xG0XOaB?=
 =?us-ascii?Q?gtYCN56wIP6iysFlkQnqgZLWN6SrN+psRhuIkMpJM67cb0/XCvC+EmK+vjjd?=
 =?us-ascii?Q?DTVneZhOub3Cc2/PpB4dMZGGTUAevj6xuMmxmCTZ5GOVT6bI5mlcZ1xwlc4E?=
 =?us-ascii?Q?uYVotzOKo2wICNvAsNdAp8U=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c4f3e5-211a-4f65-bc69-08d9c6b02497
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 07:36:48.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGBGo812BXf5e7/3tlq14e6El63lIj8Ehs/bUzVk00/Ou2CoqPruNRq6rQ+ysnIvX1/KNh/AQ6kShIKTqyeHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7859
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We add EXTRA_CFLAGS to the common CFLAGS of top-level Makefile which will
allow users to pass additional compile-time flags such as "-static".

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-and-tested-by: Atish Patra <atishp@rivosinc.com>
Reviewed-and-tested-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index f307c9f61981..3c839c01d4fd 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -132,7 +132,7 @@ endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-	-I$(<D) -Iinclude/$(UNAME_M) -I..
+	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS)
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
-- 
2.25.1

