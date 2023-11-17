Return-Path: <linux-kselftest+bounces-254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A408E7EF53C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 16:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69491C204D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015212B7C;
	Fri, 17 Nov 2023 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.schwarz header.i=@mail.schwarz header.b="B3IfbD/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2096.outbound.protection.outlook.com [40.107.104.96])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1739FA8;
	Fri, 17 Nov 2023 07:26:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER6vyI/wlMhXsqQLf5mHlx+ClV45Ehk+8B78OXjHGggCdoZ/1bGVJMU+dv4FV3z8PxFpHmild5Wel7bL/u3gRZERLZKx/RmUgoeLOzSfbewSmTzQhXyIYVnqE6/R0gVc6U5FKoM4YeQIllJ9wWMxHIBjgYGudKbzgt4tmXrar3VHcGWfCUivhyxs+QfzsXr+Pjb0fA99QDAadYHeC/berebPOmdXPi+OZRmDWZhfPjYjYXX1oqVPxcTzRdNuaC3HDJFk/9+Fpgy1l51sUdPGvMxW52Vwm42kUiN4klEU2po/R5XXuNFkbAXR6q89+7CXuCrGnXWj0/LG48aLKkG/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4I1s7/1rfMHoG3EZ5ZHdLs37MUqoydvv7fb0Xzi4SA=;
 b=XZyMNHF4hZ63t4XgMeeRO2arNYCGg3055t8uBYWu0C6ZpJ3bZvNLC/JGAeat1FiGr4bTZWmIUsiIutQwUk2Vvo9RfM7lZ22JMC6fSenucx2tHEqoZBCxENxrfpCbfwzCc0lgMmN+mYKtEHG+C4Vc1hFNvMcAvnNRo7uANtGx/lAS4W5R1SwyL05ldEFKxG/EELycjpfhSQnTc3af/UyskNqoWYabyJZYrK3MXYMKJ1SHpc1HXcvznkGQe0pskHHXqXr7ulyzd0HklrQbloYEe4Z3Ue2+m869VZETzob24YW65Fc/D0nep6qmP3m+xFQJh29o/dOV+uMFYY2/iDnXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.schwarz; dmarc=pass action=none header.from=mail.schwarz;
 dkim=pass header.d=mail.schwarz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.schwarz;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4I1s7/1rfMHoG3EZ5ZHdLs37MUqoydvv7fb0Xzi4SA=;
 b=B3IfbD/twcQTGyuZVL5dUkGKFhk56zke9pBbygylr3AZ1PNWzGhb2gGZLYpYXFqVIN3BQYM6l5/ism445wFtQ4/G3v/qUNVAQzDNM5irygO5YNIoaORVUpMdaF8815effo2GkZlGWdACK4CFHtty60u40qTuYRrzLnToV2nUOOvin9QwtZek3E2mo81cMtSbsV1J4ZPJBDCuge94z7nkaSnRrArAM5wyF4eK6116Qd4WVGVL4s04Xjcq9oCLBnPWgYNsfQVvVBj2VvFLx7X9YFkAIH8vv6DeZOD0toET8NbJVaNulZzStQeBr3BlzoWjjuEtWgT1NBdfuFSfyzEP7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.schwarz;
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22)
 by GVXPR10MB6008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 15:26:17 +0000
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8969:39d0:149d:7662]) by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8969:39d0:149d:7662%4]) with mapi id 15.20.7002.019; Fri, 17 Nov 2023
 15:26:15 +0000
Date: Fri, 17 Nov 2023 16:26:12 +0100
From: Felix Huettner <felix.huettner@mail.schwarz>
To: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Max Lamprecht <max.lamprecht@mail.schwarz>
Subject: [PATCH net-next] net: ctnetlink: support filtering by zone
Message-ID: <ZVeGFP2x-Wx6duYs@SIT-SDELAP4051.int.lidl.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Max Lamprecht <max.lamprecht@mail.schwarz>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5244:EE_|GVXPR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: e7934a42-31b6-4258-2249-08dbe78189a6
Content-Transfer-Encoding: quoted-printable
x-mp-schwarz-dsgvo2: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZRO47WjlHplmyigB+rPnslSrM+Hf6ieGOX00VgCKZ9TkwDnTkeQQuh8veJRa9VVoAeMt/gZMDmQhxElIawz4HWNVqTXpJgouNIfoHOXn2lkBWOQzkMF+i5DMAmJFCycMS/UwUtqU1/4C2fV5vrXmlXiaAdj0eFODgWQiT8Ng3Xunkmg9QppiaaPzLlaOR/BlhF3P5IJ13aCNUgu4NyiEOtEZhyMAhksH2q4dxMeNf//7He3cYbQl9hGhm5kfyR4tcR0PeyrE2avmJ+BKdhK9XErq8dG02sdtooTGJnekprYrTmFsssNIWSKMl6cAloUcOAysn18Bk4JDbIiRBOdsjZeMkkmci4easY8b2a09mnHR5gXfctMwv1gjNVpn5q7hkgwOjfRU8kbhE8fPkmN4PRXafAB6kQcdlvIy4W3Jj1JvtjOtDezBv9RnT43n4vZEhC7mZpzjJJZzYMJ4vNuo1To+UCLtmtYcnTUejxP8jVJuulx5BG2/FrP/8sUydURBRcAOUGaG1YWeT3TR8DLEXPisIQhtIlh2OykA1Tx0nx41dEmWQKZRcbtcFRor1BBS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66574015)(83380400001)(26005)(82960400001)(6666004)(478600001)(6512007)(9686003)(6506007)(6486002)(44832011)(8676002)(8936002)(4326008)(41300700001)(2906002)(38100700002)(30864003)(86362001)(7416002)(5660300002)(54906003)(66476007)(66946007)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hspiG1t06d3Wx+T3LukBUwz/mix+RzVNmoOwJUfeC4yS3c7BmtmpubCbNElQ?=
 =?us-ascii?Q?jW0dqPPNFDy53o6sfIm/UyTRR1zTFN0ZqvQ2p2IPZudB6ot+uuR2Jah3cBt0?=
 =?us-ascii?Q?a19QjW7yJa8j8Q3h6W0+NdrUzlaTyiW2kwv7xvfGejDbMujzLVzUtU/hSmxO?=
 =?us-ascii?Q?n2SXJCd6+qmQ3bIw+gRfjFDzp20eIb6emLf2TScCIZFLuRdpK8oiUOHxnm9F?=
 =?us-ascii?Q?0sPFULQ0LlphO33/ZKsDvO4J+NKMFPqveCgcu34yD/QgIuyK20FXoULIdP6L?=
 =?us-ascii?Q?OEKcmQZpd363dsRhH33xxrFaYuANvlZ19rPCwAf4HE7HxXfh1j+0TkWnPOCR?=
 =?us-ascii?Q?61OSKHdBSCUXB0/6bqa9T2Ls3B/jwx7dz0jl2klfNSH37WQlSc6ya1xUD1ol?=
 =?us-ascii?Q?UfnlJXz9P2IL2tqOI+7O2KM13nlCtgvEr8fm+D7vphxtjhMz6+6i4DIHFQrR?=
 =?us-ascii?Q?ecddTqXadZ+ndXdZb1Go4zgN2M/zJJ0rALwqAQWcQYrmGd2Pphvp/ubGE689?=
 =?us-ascii?Q?pEVtN715j9whhv4edvWe9oBs9cjAk2b/99jToM7ixjZymyPJ3JNSgMjiPq//?=
 =?us-ascii?Q?ddAlBH0+rabtt3hf24ZN/hpnj1DjHQ4BjeJFwv5v6tivIsb3hg2a7wcfitS0?=
 =?us-ascii?Q?gQuAumU/wrSY06WLVPjk4Sh7mQWV/ioy94SZmbwXVhf0qbdfNIfpQqeUwvu9?=
 =?us-ascii?Q?k4RC7oliRNvqxhAH3aRHJSVue0z2lMhEIUXziqLklFL68hxxntFj6x0INAbI?=
 =?us-ascii?Q?stfjFLJwLfL/bVyCNC/FJHeKN5+qXJ4hwIJo1LVJ4KS9rTix331uzKZukdNK?=
 =?us-ascii?Q?x+W3a/TzLZJB4OxnW2adPLakgFCVDcRu0+09Q8LbXwQS6Rnk6anZkJVio5eE?=
 =?us-ascii?Q?+m0SS00SaBOJ27h5bEAwBkkS5odBRHKhSubYTA36T7Rg73XZIO0WN7NHMz7s?=
 =?us-ascii?Q?HWOP+7U+u+BzTo7rr8u+MvvEg3IvFcoxFLw5jIL+zPVarFei0LJe+xfCnSrB?=
 =?us-ascii?Q?VqUBIMX5dtz+xBALXX+K9zvzrh5oidTs0Ul+c6f5TeG5OeB190rA7sfsCUUL?=
 =?us-ascii?Q?wYo/2feW3hSalgIqbc9ypIExwE4AUewTBS2D0lSdwKB51QkHPkjhkudp8mSf?=
 =?us-ascii?Q?LYFIMxq7NV77prqaYktHnGOwNYxgIfhfJKfy2L18OANi/MbF2j5WOQiF6YfN?=
 =?us-ascii?Q?+K98LKgw4DTWVIKqDdehI9u0T/Kqa26fUzpwMN2U1eeCtwzcsRrhQn7PtPOz?=
 =?us-ascii?Q?TdFy8ARIMe1xRtn7uyZiKRlqEczlrsyYQzHGmzsOlVMpFe9vzEtq7ZJDx7bw?=
 =?us-ascii?Q?ssY58gg0c2LAsG0Kk3QM0afnmkWdGryAPakyhnAKfHntk5EfZVS/EAnerqua?=
 =?us-ascii?Q?+TU2/O0LN19UzUmrbpQjeBf3CwRQezSVV7Z5KqzdMPmaKJOyoaLmq1EjmkGp?=
 =?us-ascii?Q?4HxXS1jzDaLoS1hwp1MawJfzGSzSUpOPAhP4qa/Pw/NThTAQ9KegGs4XN5xz?=
 =?us-ascii?Q?k+fRBBbD797B468I14Xb7OVYOVTpHVKn8sqLDBK2Y6FIstxfDcBqpBp7pDJx?=
 =?us-ascii?Q?j5vCrUCwT3YDePIUh5MR/4H99HEUeMmNbL5QdP39jUMuhPQvbBax1Hul9yMG?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: mail.schwarz
X-MS-Exchange-CrossTenant-Network-Message-Id: e7934a42-31b6-4258-2249-08dbe78189a6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 15:26:15.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d04f4717-5a6e-4b98-b3f9-6918e0385f4c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mo4pNQYyrUrZQyDdDs0g0PEMiYhgaPMKhNaN4WCeK3DTtnusBpQhx63j2iwYFA34m6xa+8MhynI/D0zw2UgHQV4Fq2p4NF35jD2dH3jq5iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6008

conntrack zones are heavily used by tools like openvswitch to run
multiple virtual "routers" on a single machine. In this context each
conntrack zone matches to a single router, thereby preventing
overlapping IPs from becoming issues.
In these systems it is common to operate on all conntrack entries of a
given zone, e.g. to delete them when a router is deleted. Previously this
required these tools to dump the full conntrack table and filter out the
relevant entries in userspace potentially causing performance issues.

To do this we reuse the existing CTA_ZONE attribute. This was previous
parsed but not used during dump and flush requests. Now if CTA_ZONE is
set we filter these operations based on the provided zone.
However this means that users that previously passed CTA_ZONE will
experience a difference in functionality.

Alternatively CTA_FILTER could have been used for the same
functionality. However it is not yet supported during flush requests and
is only available when using AF_INET or AF_INET6.

Co-developed-by: Luca Czesla <luca.czesla@mail.schwarz>
Signed-off-by: Luca Czesla <luca.czesla@mail.schwarz>
Co-developed-by: Max Lamprecht <max.lamprecht@mail.schwarz>
Signed-off-by: Max Lamprecht <max.lamprecht@mail.schwarz>
Signed-off-by: Felix Huettner <felix.huettner@mail.schwarz>
---
 net/netfilter/nf_conntrack_netlink.c          |  15 +-
 tools/testing/selftests/netfilter/.gitignore  |   2 +
 tools/testing/selftests/netfilter/Makefile    |   3 +-
 .../netfilter/conntrack_dump_flush.c          | 430 ++++++++++++++++++
 4 files changed, 444 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/netfilter/conntrack_dump_flush.=
c

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntr=
ack_netlink.c
index fb0ae15e96df..4e9133f61251 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -992,13 +992,13 @@ ctnetlink_alloc_filter(const struct nlattr * const cd=
a[], u8 family)
        if (err)
                goto err_filter;

+       err =3D ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
+       if (err < 0)
+               goto err_filter;
+
        if (!cda[CTA_FILTER])
                return filter;

-       err =3D ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
-       if (err < 0)
-               goto err_filter;
-
        err =3D ctnetlink_parse_filter(cda[CTA_FILTER], filter);
        if (err < 0)
                goto err_filter;
@@ -1043,7 +1043,8 @@ ctnetlink_alloc_filter(const struct nlattr * const cd=
a[], u8 family)

 static bool ctnetlink_needs_filter(u8 family, const struct nlattr * const =
*cda)
 {
-       return family || cda[CTA_MARK] || cda[CTA_FILTER] || cda[CTA_STATUS=
];
+       return family || cda[CTA_MARK] || cda[CTA_FILTER] || cda[CTA_STATUS=
] ||
+               cda[CTA_ZONE];
 }

 static int ctnetlink_start(struct netlink_callback *cb)
@@ -1148,6 +1149,10 @@ static int ctnetlink_filter_match(struct nf_conn *ct=
, void *data)
        if (filter->family && nf_ct_l3num(ct) !=3D filter->family)
                goto ignore_entry;

+       if (filter->zone.id !=3D NF_CT_DEFAULT_ZONE_ID &&
+           !nf_ct_zone_equal_any(ct, &filter->zone))
+               goto ignore_entry;
+
        if (filter->orig_flags) {
                tuple =3D nf_ct_tuple(ct, IP_CT_DIR_ORIGINAL);
                if (!ctnetlink_filter_match_tuple(&filter->orig, tuple,
diff --git a/tools/testing/selftests/netfilter/.gitignore b/tools/testing/s=
elftests/netfilter/.gitignore
index 4b2928e1c19d..c2229b3e40d4 100644
--- a/tools/testing/selftests/netfilter/.gitignore
+++ b/tools/testing/selftests/netfilter/.gitignore
@@ -2,3 +2,5 @@
 nf-queue
 connect_close
 audit_logread
+conntrack_dump_flush
+sctp_collision
diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/sel=
ftests/netfilter/Makefile
index bced422b78f7..db27153eb4a0 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -14,6 +14,7 @@ HOSTPKG_CONFIG :=3D pkg-config
 CFLAGS +=3D $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
 LDLIBS +=3D $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -l=
mnl)

-TEST_GEN_FILES =3D  nf-queue connect_close audit_logread sctp_collision
+TEST_GEN_FILES =3D  nf-queue connect_close audit_logread sctp_collision \
+       conntrack_dump_flush

 include ../lib.mk
diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/too=
ls/testing/selftests/netfilter/conntrack_dump_flush.c
new file mode 100644
index 000000000000..61bfb2be468a
--- /dev/null
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <time.h>
+#include <libmnl/libmnl.h>
+#include <netinet/ip.h>
+
+#include <linux/netlink.h>
+#include <linux/netfilter/nfnetlink.h>
+#include <linux/netfilter/nfnetlink_conntrack.h>
+#include <linux/netfilter/nf_conntrack_tcp.h>
+#include "../kselftest_harness.h"
+
+#define TEST_ZONE_ID 123
+#define CTA_FILTER_F_CTA_TUPLE_ZONE (1 << 2)
+
+static int reply_counter;
+
+static int build_cta_tuple_v4(struct nlmsghdr *nlh, int type,
+                             uint32_t src_ip, uint32_t dst_ip,
+                             uint16_t src_port, uint16_t dst_port)
+{
+       struct nlattr *nest, *nest_ip, *nest_proto;
+
+       nest =3D mnl_attr_nest_start(nlh, type);
+       if (!nest)
+               return -1;
+
+       nest_ip =3D mnl_attr_nest_start(nlh, CTA_TUPLE_IP);
+       if (!nest_ip)
+               return -1;
+       mnl_attr_put_u32(nlh, CTA_IP_V4_SRC, src_ip);
+       mnl_attr_put_u32(nlh, CTA_IP_V4_DST, dst_ip);
+       mnl_attr_nest_end(nlh, nest_ip);
+
+       nest_proto =3D mnl_attr_nest_start(nlh, CTA_TUPLE_PROTO);
+       if (!nest_proto)
+               return -1;
+       mnl_attr_put_u8(nlh, CTA_PROTO_NUM, 6);
+       mnl_attr_put_u16(nlh, CTA_PROTO_SRC_PORT, htons(src_port));
+       mnl_attr_put_u16(nlh, CTA_PROTO_DST_PORT, htons(dst_port));
+       mnl_attr_nest_end(nlh, nest_proto);
+
+       mnl_attr_nest_end(nlh, nest);
+}
+
+static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
+                             struct in6_addr src_ip, struct in6_addr dst_i=
p,
+                             uint16_t src_port, uint16_t dst_port)
+{
+       struct nlattr *nest, *nest_ip, *nest_proto;
+
+       nest =3D mnl_attr_nest_start(nlh, type);
+       if (!nest)
+               return -1;
+
+       nest_ip =3D mnl_attr_nest_start(nlh, CTA_TUPLE_IP);
+       if (!nest_ip)
+               return -1;
+       mnl_attr_put(nlh, CTA_IP_V6_SRC, sizeof(struct in6_addr), &src_ip);
+       mnl_attr_put(nlh, CTA_IP_V6_DST, sizeof(struct in6_addr), &dst_ip);
+       mnl_attr_nest_end(nlh, nest_ip);
+
+       nest_proto =3D mnl_attr_nest_start(nlh, CTA_TUPLE_PROTO);
+       if (!nest_proto)
+               return -1;
+       mnl_attr_put_u8(nlh, CTA_PROTO_NUM, 6);
+       mnl_attr_put_u16(nlh, CTA_PROTO_SRC_PORT, htons(src_port));
+       mnl_attr_put_u16(nlh, CTA_PROTO_DST_PORT, htons(dst_port));
+       mnl_attr_nest_end(nlh, nest_proto);
+
+       mnl_attr_nest_end(nlh, nest);
+}
+
+static int build_cta_proto(struct nlmsghdr *nlh)
+{
+       struct nlattr *nest, *nest_proto;
+
+       nest =3D mnl_attr_nest_start(nlh, CTA_PROTOINFO);
+       if (!nest)
+               return -1;
+
+       nest_proto =3D mnl_attr_nest_start(nlh, CTA_PROTOINFO_TCP);
+       if (!nest_proto)
+               return -1;
+       mnl_attr_put_u8(nlh, CTA_PROTOINFO_TCP_STATE, TCP_CONNTRACK_ESTABLI=
SHED);
+       mnl_attr_put_u16(nlh, CTA_PROTOINFO_TCP_FLAGS_ORIGINAL, 0x0a0a);
+       mnl_attr_put_u16(nlh, CTA_PROTOINFO_TCP_FLAGS_REPLY, 0x0a0a);
+       mnl_attr_nest_end(nlh, nest_proto);
+
+       mnl_attr_nest_end(nlh, nest);
+}
+
+static int conntrack_data_insert(struct mnl_socket *sock, struct nlmsghdr =
*nlh,
+                                uint16_t zone)
+{
+       char buf[MNL_SOCKET_BUFFER_SIZE];
+       struct nlmsghdr *rplnlh;
+       unsigned int portid;
+       int err, ret;
+
+       portid =3D mnl_socket_get_portid(sock);
+
+       ret =3D build_cta_proto(nlh);
+       if (ret < 0) {
+               perror("build_cta_proto");
+               return -1;
+       }
+       mnl_attr_put_u32(nlh, CTA_TIMEOUT, htonl(20000));
+       mnl_attr_put_u16(nlh, CTA_ZONE, htons(zone));
+
+       if (mnl_socket_sendto(sock, nlh, nlh->nlmsg_len) < 0) {
+               perror("mnl_socket_sendto");
+               return -1;
+       }
+
+       ret =3D mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+       if (ret < 0) {
+               perror("mnl_socket_recvfrom");
+               return ret;
+       }
+
+       ret =3D mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid, NULL, NULL);
+       if (ret < 0) {
+               if (errno =3D=3D EEXIST) {
+                       /* The entries are probably still there from a prev=
ious
+                        * run. So we are good
+                        */
+                       return 0;
+               }
+               perror("mnl_cb_run");
+               return ret;
+       }
+
+       return 0;
+}
+
+static int conntracK_data_generate_v4(struct mnl_socket *sock, uint32_t sr=
c_ip,
+                                     uint32_t dst_ip, uint16_t zone)
+{
+       char buf[MNL_SOCKET_BUFFER_SIZE];
+       struct nlmsghdr *nlh;
+       struct nfgenmsg *nfh;
+       int ret;
+
+       nlh =3D mnl_nlmsg_put_header(buf);
+       nlh->nlmsg_type =3D (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_NE=
W;
+       nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_CREATE |
+                          NLM_F_ACK | NLM_F_EXCL;
+       nlh->nlmsg_seq =3D time(NULL);
+
+       nfh =3D mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+       nfh->nfgen_family =3D AF_INET;
+       nfh->version =3D NFNETLINK_V0;
+       nfh->res_id =3D 0;
+
+       ret =3D build_cta_tuple_v4(nlh, CTA_TUPLE_ORIG, src_ip, dst_ip, 123=
45, 443);
+       if (ret < 0) {
+               perror("build_cta_tuple_v4");
+               return ret;
+       }
+       ret =3D build_cta_tuple_v4(nlh, CTA_TUPLE_REPLY, dst_ip, src_ip, 44=
3, 12345);
+       if (ret < 0) {
+               perror("build_cta_tuple_v4");
+               return ret;
+       }
+       return conntrack_data_insert(sock, nlh, zone);
+}
+
+static int conntracK_data_generate_v6(struct mnl_socket *sock,
+                                     struct in6_addr src_ip,
+                                     struct in6_addr dst_ip,
+                                     uint16_t zone)
+{
+       char buf[MNL_SOCKET_BUFFER_SIZE];
+       struct nlmsghdr *nlh;
+       struct nfgenmsg *nfh;
+       int ret;
+
+       nlh =3D mnl_nlmsg_put_header(buf);
+       nlh->nlmsg_type =3D (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_NE=
W;
+       nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_CREATE |
+                          NLM_F_ACK | NLM_F_EXCL;
+       nlh->nlmsg_seq =3D time(NULL);
+
+       nfh =3D mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+       nfh->nfgen_family =3D AF_INET6;
+       nfh->version =3D NFNETLINK_V0;
+       nfh->res_id =3D 0;
+
+       ret =3D build_cta_tuple_v6(nlh, CTA_TUPLE_ORIG, src_ip, dst_ip,
+                                12345, 443);
+       if (ret < 0) {
+               perror("build_cta_tuple_v6");
+               return ret;
+       }
+       ret =3D build_cta_tuple_v6(nlh, CTA_TUPLE_REPLY, dst_ip, src_ip,
+                                12345, 443);
+       if (ret < 0) {
+               perror("build_cta_tuple_v6");
+               return ret;
+       }
+       return conntrack_data_insert(sock, nlh, zone);
+}
+
+static int count_entries(const struct nlmsghdr *nlh, void *data)
+{
+       reply_counter++;
+}
+
+static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)
+{
+       char buf[MNL_SOCKET_BUFFER_SIZE];
+       struct nlmsghdr *nlh, *rplnlh;
+       struct nfgenmsg *nfh;
+       struct nlattr *nest;
+       unsigned int portid;
+       int err, ret;
+
+       portid =3D mnl_socket_get_portid(sock);
+
+       nlh =3D mnl_nlmsg_put_header(buf);
+       nlh->nlmsg_type =3D (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_GE=
T;
+       nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_DUMP;
+       nlh->nlmsg_seq =3D time(NULL);
+
+       nfh =3D mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+       nfh->nfgen_family =3D AF_UNSPEC;
+       nfh->version =3D NFNETLINK_V0;
+       nfh->res_id =3D 0;
+
+       mnl_attr_put_u16(nlh, CTA_ZONE, htons(zone));
+
+       ret =3D mnl_socket_sendto(sock, nlh, nlh->nlmsg_len);
+       if (ret < 0) {
+               perror("mnl_socket_sendto");
+               return ret;
+       }
+
+       reply_counter =3D 0;
+       ret =3D mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+       while (ret > 0) {
+               ret =3D mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid,
+                                count_entries, NULL);
+               if (ret <=3D MNL_CB_STOP)
+                       break;
+
+               ret =3D mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SI=
ZE);
+       }
+       if (ret < 0) {
+               perror("mnl_socket_recvfrom");
+               return ret;
+       }
+
+       return reply_counter;
+}
+
+static int conntrack_flush_zone(struct mnl_socket *sock, uint16_t zone)
+{
+       char buf[MNL_SOCKET_BUFFER_SIZE];
+       struct nlmsghdr *nlh, *rplnlh;
+       struct nfgenmsg *nfh;
+       struct nlattr *nest;
+       unsigned int portid;
+       int err, ret;
+
+       portid =3D mnl_socket_get_portid(sock);
+
+       nlh =3D mnl_nlmsg_put_header(buf);
+       nlh->nlmsg_type =3D (NFNL_SUBSYS_CTNETLINK << 8) | IPCTNL_MSG_CT_DE=
LETE;
+       nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
+       nlh->nlmsg_seq =3D time(NULL);
+
+       nfh =3D mnl_nlmsg_put_extra_header(nlh, sizeof(struct nfgenmsg));
+       nfh->nfgen_family =3D AF_UNSPEC;
+       nfh->version =3D NFNETLINK_V0;
+       nfh->res_id =3D 0;
+
+       mnl_attr_put_u16(nlh, CTA_ZONE, htons(zone));
+
+       ret =3D mnl_socket_sendto(sock, nlh, nlh->nlmsg_len);
+       if (ret < 0) {
+               perror("mnl_socket_sendto");
+               return ret;
+       }
+
+       ret =3D mnl_socket_recvfrom(sock, buf, MNL_SOCKET_BUFFER_SIZE);
+       if (ret < 0) {
+               perror("mnl_socket_recvfrom");
+               return ret;
+       }
+
+       ret =3D mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid, NULL, NULL);
+       if (ret < 0) {
+               perror("mnl_cb_run");
+               return ret;
+       }
+
+       return 0;
+}
+
+FIXTURE(conntrack_dump_flush)
+{
+       struct mnl_socket *sock;
+};
+
+FIXTURE_SETUP(conntrack_dump_flush)
+{
+       struct in6_addr src, dst;
+       int ret;
+
+       self->sock =3D mnl_socket_open(NETLINK_NETFILTER);
+       if (!self->sock) {
+               perror("mnl_socket_open");
+               exit(EXIT_FAILURE);
+       }
+
+       if (mnl_socket_bind(self->sock, 0, MNL_SOCKET_AUTOPID) < 0) {
+               perror("mnl_socket_bind");
+               exit(EXIT_FAILURE);
+       }
+
+       ret =3D conntracK_count_zone(self->sock, TEST_ZONE_ID);
+       if (ret < 0 && errno =3D=3D EPERM)
+               SKIP(return, "Needs to be run as root");
+       else if (ret < 0 && errno =3D=3D EOPNOTSUPP)
+               SKIP(return, "Kernel does not seem to support conntrack zon=
es");
+
+       ret =3D conntracK_data_generate_v4(self->sock, 0xf0f0f0f0, 0xf1f1f1=
f1,
+                                        TEST_ZONE_ID);
+       EXPECT_EQ(ret, 0);
+       ret =3D conntracK_data_generate_v4(self->sock, 0xf2f2f2f2, 0xf3f3f3=
f3,
+                                        TEST_ZONE_ID + 1);
+       EXPECT_EQ(ret, 0);
+       ret =3D conntracK_data_generate_v4(self->sock, 0xf4f4f4f4, 0xf5f5f5=
f5,
+                                        TEST_ZONE_ID + 2);
+       EXPECT_EQ(ret, 0);
+
+       src =3D (struct in6_addr) {{
+               .__u6_addr32 =3D {
+                       0xb80d0120,
+                       0x00000000,
+                       0x00000000,
+                       0x01000000
+               }
+       }};
+       dst =3D (struct in6_addr) {{
+               .__u6_addr32 =3D {
+                       0xb80d0120,
+                       0x00000000,
+                       0x00000000,
+                       0x02000000
+               }
+       }};
+       ret =3D conntracK_data_generate_v6(self->sock, src, dst,
+                                        TEST_ZONE_ID);
+       EXPECT_EQ(ret, 0);
+       src =3D (struct in6_addr) {{
+               .__u6_addr32 =3D {
+                       0xb80d0120,
+                       0x00000000,
+                       0x00000000,
+                       0x03000000
+               }
+       }};
+       dst =3D (struct in6_addr) {{
+               .__u6_addr32 =3D {
+                       0xb80d0120,
+                       0x00000000,
+                       0x00000000,
+                       0x04000000
+               }
+       }};
+       ret =3D conntracK_data_generate_v6(self->sock, src, dst,
+                                        TEST_ZONE_ID + 1);
+       EXPECT_EQ(ret, 0);
+       src =3D (struct in6_addr) {{
+               .__u6_addr32 =3D {
+                       0xb80d0120,
+                       0x00000000,
+                       0x00000000,
+                       0x05000000
+               }
+       }};
+       dst =3D (struct in6_addr) {{
+               .__u6_addr32 =3D {
+                       0xb80d0120,
+                       0x00000000,
+                       0x00000000,
+                       0x06000000
+               }
+       }};
+       ret =3D conntracK_data_generate_v6(self->sock, src, dst,
+                                        TEST_ZONE_ID + 2);
+       EXPECT_EQ(ret, 0);
+
+       ret =3D conntracK_count_zone(self->sock, TEST_ZONE_ID);
+       EXPECT_GE(ret, 2);
+       if (ret > 2)
+               SKIP(return, "kernel does not support filtering by zone");
+}
+
+FIXTURE_TEARDOWN(conntrack_dump_flush)
+{
+}
+
+TEST_F(conntrack_dump_flush, test_dump_by_zone)
+{
+       int ret;
+
+       ret =3D conntracK_count_zone(self->sock, TEST_ZONE_ID);
+       EXPECT_EQ(ret, 2);
+}
+
+TEST_F(conntrack_dump_flush, test_flush_by_zone)
+{
+       int ret;
+
+       ret =3D conntrack_flush_zone(self->sock, TEST_ZONE_ID);
+       EXPECT_EQ(ret, 0);
+       ret =3D conntracK_count_zone(self->sock, TEST_ZONE_ID);
+       EXPECT_EQ(ret, 0);
+       ret =3D conntracK_count_zone(self->sock, TEST_ZONE_ID + 1);
+       EXPECT_EQ(ret, 2);
+       ret =3D conntracK_count_zone(self->sock, TEST_ZONE_ID + 2);
+       EXPECT_EQ(ret, 2);
+}
+
+TEST_HARNESS_MAIN

base-commit: 18de1e517ed37ebaf33e771e46faf052e966e163
--
2.42.0

Diese E Mail enth=C3=A4lt m=C3=B6glicherweise vertrauliche Inhalte und ist =
nur f=C3=BCr die Verwertung durch den vorgesehenen Empf=C3=A4nger bestimmt.
Sollten Sie nicht der vorgesehene Empf=C3=A4nger sein, setzen Sie den Absen=
der bitte unverz=C3=BCglich in Kenntnis und l=C3=B6schen diese E Mail.

Hinweise zum Datenschutz finden Sie hier<https://www.datenschutz.schwarz>.


This e-mail may contain confidential content and is intended only for the s=
pecified recipient/s.
If you are not the intended recipient, please inform the sender immediately=
 and delete this e-mail.

Information on data protection can be found here<https://www.datenschutz.sc=
hwarz>.

