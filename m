Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C8D7470B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGDMWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDMWN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE6E70;
        Tue,  4 Jul 2023 05:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSXfMkrZRMTtF1Yny0Aq9Fu2hGjnuAJDMGbbuFwG4pC2/Ih8PPZR5+NbjcAqn74Ruy16cMnh5CZ8ErsRJs6NTpiXizk3x1uyTEB8wgqNT3dqFaRLmOhHz2P8tCDFEn3T4EaMiMYQq96ZFXsOu9S6T9DWbFzKQWK7mX3fvmk10IVbeX41ebBmnJtxDR0RysR6XB1kC/fT+swu3wGFP+qJVikb+zZ4fBHXjGAeJtUypoh/jxeUU6ybmJLaLkXb7feEfD51yqDmdyU5SCoOdmTY78R5+9gAj4oK2/qmoRW4MRXJ0fkwWO9x1et/XPjP2XThbnKWQs5hxXVF3jVYoO6BtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mITg8/+XJVzuWzBr5eHjyB3cikXNrlR/IKL0rqjV2Xc=;
 b=QlD2hzDc0gVFaxxY22xo3sjHsNT2f3xGtFhQWzlP2PmNtGvG5UfyxfdeZ5YxrRRXyyKTZVp0Tz/Ql4mAluVTpAW9LnSQlJOaLFCCY0GqXqmZbdrue9Q4hKGs5rJjFeSHtUjRtqZV/7ErTtn0+//8b2iNizFSLU8YaPDn7AVbGLyck/4iz2opvqXNQhlAVwqm5PQJ+wBVWEaLNRt3Ak2s6krrbITIPuncyRpTuREHNi/Pu2/GOGQzfP9jCwQY8ucsMfg50f66gpfCj4GAQNzYW+vWb7ZirW3T7XtUYJS0FkZJcDHCDPlxRd9E6r0h6SGYJHN6D1fAsglmmpvEMi18dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mITg8/+XJVzuWzBr5eHjyB3cikXNrlR/IKL0rqjV2Xc=;
 b=eG1Wwy5UqLADef48aRXAe99jR/r+0czqK0TSWcCXyhOib56rcEuSSMoTqKWgTCuu7LP3y2Ja3zXspt9znATYfgxMbUc++Nd297j2yiPIy+yn+c4v8XbCp0zmeovSTSEiSscMgLC+0AZ/1jpOk4ElUDeWN9GjdvWuG2Du9JLGFWw4FRPZSHx+Ifd0ZqeT0f20b3Ir1u/WpLUc/i6llWsCZM/9pKWZNYYeYiqmwwEToNaaQaIVQiwdTIKBPkzrlmWHfoNMCzlfk987YPwc+W1HdwRtk7/R4rHsZLilBLnj0sidwO8yah7cWo0Is/Nt6e18Psq/Xhjz7BHAp4kDONKMZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB6464.apcprd06.prod.outlook.com (2603:1096:400:459::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Tue, 4 Jul 2023 12:22:06 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:22:06 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] tools: remove duplicate assignment
Date:   Tue,  4 Jul 2023 20:21:47 +0800
Message-Id: <20230704122148.11573-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::36) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da624ef-9927-4c91-3fb0-08db7c8947b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJnZU27WxPMh9uCUX0EAQBIYV2CCaROius3IxzO/RJ4dbKZZNAzs6MVeb2uGh2vSg71bTqLpwtTdQ010ZUlMwJClnwtzKcRIen4OEviPCpQYJRqld8VxDbMoqvWDDa8ts29UuoBxI4dvLj7LFmZJzFB2r2uZ5jdNKY+kaGIgbh92Ah5i8X1dBeeu+zH86zsi6nDthtEcq9YWr5k2lVsMPs7P+SkmrfoPCgIWhi9en2uXvf/zPiUmIRwabMyVmMzNj2FRd2A4A6qFUXbZF5vkKuJllNQsXuGVV37wOnrzd4PzQVO2UNyaRd/txpYHyeWlK7+KfI//A91L6yrjILX7AwZwm3/c6rnM+gmmdTeUPtABu2weVHtANL811qHN+qCib+wLEKDksFMndCYWdCb3w3xSnWE8ZTmz4vyUPMUGKmmkDSE6W+Zl5u1gMaqs4wfDlkUrlNUJY3t355ykwQSVzZ+2hRUT3TttWUxBQcrYsdE2vwEdnAvzu0HOdPkjoAQPXcbhTW+H0n2CPals7WRBtV5bn47w7QMiR890mvY/S4IfSEJ84VFXMBxnKCrrx7cnLPkS+fioXWKStuV+2cxWE+ZG/Ca3uqt4+n+s6/1VFMh26jnkKo+qmiXHTcF93ukR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(366004)(396003)(376002)(136003)(451199021)(66946007)(66556008)(66476007)(4326008)(36756003)(478600001)(316002)(8936002)(8676002)(5660300002)(2906002)(4744005)(41300700001)(110136005)(86362001)(52116002)(6486002)(6512007)(1076003)(186003)(26005)(38100700002)(6506007)(6666004)(38350700002)(83380400001)(2616005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2I5mYG9Iiz4lFAJMRw5rSFXsGy38laHAav++ZEt0HdwGN1wlfYVkJwQqYdg?=
 =?us-ascii?Q?NoyIJ48Jhkw29g3tXWGskugnry5OO52OM4ZV07OoM5ZKBnhFOAlGbWzQlUkI?=
 =?us-ascii?Q?60IlMtbNe+GYggeEGJMCjEIpMmUQ+gLqlXO/fG/O3KIRbfFafi1mIVVLm0q4?=
 =?us-ascii?Q?8NIPxrsu0w/Ni/RQWzP1G0GFu2lVGq49BSYO450UcaYdHdyOPA/1uRIRg/8S?=
 =?us-ascii?Q?rwMYiObvB3KxNChyQPQY9Hxx585WVRzk/U2nRM7FGavRSDh4Cr5wupYIxj/4?=
 =?us-ascii?Q?Mrd3fwHY7VX0p1QSPLXTJa8zbveGBZ+4qXmwUDmsRGZlXApK88p6Ne8F/SXo?=
 =?us-ascii?Q?VMMKqOXczSjpAmrEn+Bt2373epRNPJHYAKxRmB38hU4nzwwHrosfQNs/cdD7?=
 =?us-ascii?Q?W94iJOg/HTm0xhmWbVmpLD9EbM3tnBCkBRWkFbp9qOHkabsv8YUzJ7X0tC0s?=
 =?us-ascii?Q?YPyscgxRxYyGjPK03Tv8xmbL+TLMvEMnki5UsUK/sFVHEjFhQttbR6yybXUy?=
 =?us-ascii?Q?aBsm76tc7vMJOd1xp8yNZTRxXQJx9P9H2raPA17Uzxludqh2TuX4d/ney3MD?=
 =?us-ascii?Q?kcr5WWxZ2RTAeLbctxrxzQKqvxXnTmp3uzFSgfTnfbXlh2Idj70Pr7nVBCaF?=
 =?us-ascii?Q?fBBrRTJ/WO529MPyM9886Kdx9T+P3umxFBNln+eV23/Hsgzba71pz9hrPp6W?=
 =?us-ascii?Q?LynA+dvJ+bwaj+0rquS3g/iQgY/Rn0xToqTHu9VQNm+PVWrgy9wN634NvFqB?=
 =?us-ascii?Q?4fb3rDonyti+uuOuIwLMguPxqOiE5eVk2nEM9bVnUEsPrTZmFlqPYqeaVzhv?=
 =?us-ascii?Q?rRnIUFiILBDjOzpWkl7l6bk7sje79+jnh+DC48KOi2fya1eGMFqUgQHWTxEP?=
 =?us-ascii?Q?pvZgKI6ck87Zg0NK7YVO/TStiRMJGSna7gxEQHrPF42QMg9qpWvX1vUm3vQJ?=
 =?us-ascii?Q?OGdbwCMuhZ6QJF6gTKqXE0YFi86ktQmH6xzxkSs14mFUi06+3lJTHAw+hS4L?=
 =?us-ascii?Q?75oamiIYsFHRaGexOaNuBN+jqbiNqY9AFyUneT1lKDhJ5rLh3TQKlKYBJ96F?=
 =?us-ascii?Q?1i+8ezm1Hs52CPVvy8yMXiAPOEUnm/Zebv7ZgnVQylujylVg/O7X0WiAtNjq?=
 =?us-ascii?Q?bX0S38eHstuxPblMQjLIMYp3z/z43zSHd+mfJVpmxyiDi0Lb236OWcriB2YX?=
 =?us-ascii?Q?6OxLXrDLf8yRTLEBLyLKevnZk/DUAaTjxNRIoiDGJiiuN0nm3RfnARiYeuAe?=
 =?us-ascii?Q?eS6Oa11amkluOWnCa9EUCj1MDT+WuET+C9cuurZnlfyTvgqNvZ0n6r8hhTg4?=
 =?us-ascii?Q?wTKlVKPBnr1RjH37dlwR4qqpltLFiRMaOUTKzxLVUvjsFaVyujoJp5nXDN60?=
 =?us-ascii?Q?tqQNe3yA41aW+Ze+jdH1GhPGiUiubttIDw8YMc4oM0mONN6wirxOwM47mV9b?=
 =?us-ascii?Q?5AkYtrJ2e32kI+uYHR4CG7AG6O4lCYmm0Gtd+U+h3mRzLnFpS70xujNx1hcZ?=
 =?us-ascii?Q?FNWFJKou88BcxUAZGDkcrGQUBwr2pQbjDOeqKP+uUEBJedNPNzW0JP+Myqq/?=
 =?us-ascii?Q?HHmJnyQ112yKNHHsDOV/VvYGRaFUtw7JTxaRpFso?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da624ef-9927-4c91-3fb0-08db7c8947b7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:22:06.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxuIB1D7tOhqmSl0uliE882AkiNRMIiKtSl+TC8X8O8kCorv1ML2knfRIWGsJlax1QMTnaQsRu2tmPAVh9UxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix: make 'nodep' remove duplicate assignment

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 tools/testing/selftests/kvm/lib/sparsebit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
index 50e0cf41a..88cb6b84e 100644
--- a/tools/testing/selftests/kvm/lib/sparsebit.c
+++ b/tools/testing/selftests/kvm/lib/sparsebit.c
@@ -634,7 +634,6 @@ static void node_reduce(struct sparsebit *s, struct node *nodep)
 				tmp = node_prev(s, nodep);
 
 			node_rm(s, nodep);
-			nodep = NULL;
 
 			nodep = tmp;
 			reduction_performed = true;
-- 
2.39.0

