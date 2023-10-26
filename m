Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540227D7AA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 04:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJZCFO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 22:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZCFN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 22:05:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2060.outbound.protection.outlook.com [40.92.90.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418A190;
        Wed, 25 Oct 2023 19:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuN/n9ugJxPNPafI7AjAvM6lyoyNIE+xEp6qEgZWU59dCic4+9GbLQdoflDvWr2IbDR7cIRa08X5GFyxTYJ3zvlJ2MOdUNjFfFjmAck+WCWsRCfIPWsAc/cTiLBo7iMSHhGIrti741BOsvHKvaxGMyRUDtd2mFPEA4BzA+DurcajDApEt41idgLsoukbfP3c03tYj9UioAmsc3/lS/iLVTBr6DNY1OKNCrC8z8n6yt+eJPEM26otETGyKUUw+pZKGGqzkqzN/VBQxUWUY3HdW6/cvxCaC9AKLUDMR4z5jtlNLHxzA/ePcWKi6H5I5sQf8Kg274wDbyRiPlJsQtC8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlcCnMa+gq9ToVs6Fvuge7iFBROgo7HegysrN2LIibA=;
 b=aSJ2YbIIw9a7wvDInlh7g55nQIn9yOKIsTTntsOByGgN84Uj9dcyKzvzspEK6CuXbHCc//Hasa2JneicuWi4MkqnfEbXgmijXp7+TgCSBJ3iT0dAxEOtZrO7kvu026tFgbNdMwkdJSsI4Tq1F69Oz0bmIXgnEFTSMMIg/Qb5H9diDvZz8OgOELgKSO1HvQQXIXyd/ZojSszbbhaTh1amg0byn4PgFv1Bb7+R9p8I6gKb9byJbBBAV2zjEFTKoc/yof7zVdOQyZlKk4Q7lCWvcWiGfC72g83RX0K648kJlXqR868Yjv+XOwQWj8t8zL17GAqw4lLZmSZ6Zt6IKMOYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlcCnMa+gq9ToVs6Fvuge7iFBROgo7HegysrN2LIibA=;
 b=PGbTJjdvxdC2eA9TnW6HmnpbmSBDZSBaJxIkhLXwKH5fm0ePZnQ9hdJMRjisSFEaG/w5feu1Vw49pJt8W6BqduRabMGgENIgQgnaKuyqbBvKESvdGL1NnWuxafD0pULL5Jq10xChJ7cGRC6RKaTebnT8tGvcHHi4LIyUX4Dc84jRJovIlJeKTZOK0YoNyrMw4cRbeHOcmQPnCRr55XhC6luaT05S/ICuyrAOLTui+0DVE0EstYAuXjnwX6QUMTkszfo09UGaX4X0UXDn4OgMPA76Y0OkaOP2JhOCJvqIiw4WNuJFwz7oJnjzUu+2BKdOYJ4SKFD+MKDIatQ6o10qAw==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AS2PR10MB7048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 02:05:08 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 02:05:08 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     bpf@vger.kernel.org, yonghong.song@linux.dev
Cc:     sinquersw@gmail.com, shuah@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, brauner@kernel.org,
        iii@linux.ibm.com, kuifeng@meta.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuran Pereira <yuran.pereira@hotmail.com>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: Replaces CHECK macros and adds malloc failure checks to bpf_iter
Date:   Thu, 26 Oct 2023 07:33:17 +0530
Message-ID: <DB3PR10MB6835598B901975BEAEBA8601E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bSNAGxQf6DX7V24PetHib9rzSjSFxfBa]
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231026020319.1203600-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AS2PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d8a72a-aba0-4b55-c267-08dbd5c7fa6b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jufkgZzNZcvswShHVENCdbce+WdISqP2wxfH9JYt9xImoEuT94cSrOSUVNkx58cjEhdyVX1yupkiDyPfE4QvYWDENsHnRFBz4s6JjRDi05vNKKcQHFs5PyoVsJfCFeTOLPdYwxImN42+FL/shFAP0+EmlO1pCCgT8NqRz46QUvWkahVaKnwXfaSJ9y7wNJVLAUtsjGrddIu6UOWp+kOpO2xkSsqrgI2O4P2mCpQ95U69eV07FUPna9UE3rIPqCOduuXF/GRIawxKC7suZXSJXMKXHg6UpXKp2A/doAV06WJky1P0Qdn5PwTB+lnyA7jmpNYzOvd7wvdUDTHNu1aNYDj7PvDuOsycPneOrc3HkGKnmAlJyzntOPXDgY6tTaCKxuF9EfYrxYYXwEQAtNBqapult67lsIcdyfUn+qfgNL7PTYHKS7SpslzsiHOGW6aVR564Xz8eO1BDbWSaeJO0uiMBrBRMACGSr8pNX+FFgcHBz8tV2a+jhrYTmQM6ubUEqBmNZeEYvqO8oDV/MBx1KR1B6tqK8mqYSzg+FuODpGqYEWwj5h/Vx75V0qYwNJfSiq7r66W5aGO2tI+gsSBODnDNK5gfkjt34tO7StVqVgzNYCWkc1XJJIafZuUF1F3uBWGOlT3Ar4XhnD/Tl/GWfAPRA6GnQdT5iwQoh2tgPek=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJA1oz2f6k9/vONeeZxWgYF67/dRx4h6cbzzLb6qvUElrL4otChSZ0Z48SXx?=
 =?us-ascii?Q?BgiEG8QaRl5AYFI7+SxhPJQ8WfM3CU7YvBmYRsskQ9AFanL+6jM1KyMO9Zf7?=
 =?us-ascii?Q?UpCQVt2hnyVLaoD+ykMQGWa8Og9QwBZGo5EO0wzCsVSuh//uIpkU5Y74f4g0?=
 =?us-ascii?Q?0hKmgeEj3K/tdgWyCJmA2aVp+sKnHQ2dHaHjUoDcHQYxOGRrAagjfu1cU4oB?=
 =?us-ascii?Q?dOqTJTx9VPddWKC0zuWEXsGfOuy2PSAcOvPt+5VE+dcVx3C6L0eEgvXEAv0S?=
 =?us-ascii?Q?cdQqE2k7xJ0f15J0ZI7g3UzM99qZ3RZqbhTJ7rbQ4RCT1fK7AoODYdu72oRz?=
 =?us-ascii?Q?gNjeMLBmfBqJurp3UyxuDKGRdhLOA93m9xSbOtogyFR4qwJ8aH+OcEyzD3Bl?=
 =?us-ascii?Q?kQN3jxc0AB1cWc8Wgc5vqq/Wn37cNpbOE1fT0ppxqL89oiJ9zbhU+McxMSP8?=
 =?us-ascii?Q?o/JkAHDzBMkqiQajLA7NXVfBGcIR6S+01hVXlukgYweDbS5wJxKUb+h+sA+S?=
 =?us-ascii?Q?z3MTF+7jxNj1fK/uq2FHuY3jUypBl/qtWZ7lCODaKnMdOhwv1JFs9Rq1QFcH?=
 =?us-ascii?Q?LMIYvXcNcBIixhF/Vi08vcaIELn4dgPU74Bk3fsjmEL7WVK8AOBUERs8AcwB?=
 =?us-ascii?Q?CI4ve40KBtXlmEKOz0NuhEmxLRhyZkQmhj2XtuY6Px4Jew3CluAMVdpAoE0u?=
 =?us-ascii?Q?C06LSNuaEiQRmP/vvhyJMAr/j0HSVwX5tvxWyADpFbcLsc4i9nocod2N+Rnf?=
 =?us-ascii?Q?i+YpMEaNPrIKmtArUeX+88gpYL7BgctXUWzTWobYHfP21JUNJwpLaE44hwis?=
 =?us-ascii?Q?5bO/Mm/u5+1R90HT6h5FcxNXSpudBAh8Ppviyq9/Lw9HWRVl36QFceUocXUb?=
 =?us-ascii?Q?kG5uqzkK2Ui6N3fhV8SfJPHPsRmiJK25HewVSuOmch2YN9xV2wqb16k4yRn3?=
 =?us-ascii?Q?h3KgJmeY1ZTN36vTmjQShtxzj9kaRs3bevyr60OmbZumJp60RU4lBeeVtjLc?=
 =?us-ascii?Q?x+AId4MwirZqyPtNiYrOhxCR8K/RTB5AXgIL+8fH8rAqG4nFzSnzEIQ5VQB8?=
 =?us-ascii?Q?maOKj+UC0MyhiE7Cor9clJm0bLbtD9qLQDqDmV9y18gNQl6ve/yqz4KldSGC?=
 =?us-ascii?Q?6mJ86rlKYg34GmfPFV30MNOZT0l74eO1Xh3vxjx5nKHDHHz1YQB9QOzXnnLZ?=
 =?us-ascii?Q?ZqIPUZojKmMAkiRQKQCNlZh4g8wqltqqUyCX22CeDYl6h2lBfCgyhPrsnLw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d8a72a-aba0-4b55-c267-08dbd5c7fa6b
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:05:08.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series contains the following updates:
- Replaces the usage of all the CHECK macros in bpf_iter
  to the appropriate ASSERT_* macro calls
- Adds appropriate malloc failure checks to bpf_iter

Changes in v2:
- Removed unused "duration" variable which caused compilation error
  as reported by Yonghong Song [1]
- Improved malloc failure handling as suggested by Kui-Feng Lee [2]
- Ensured propper patch formatting (i.e. sending it as a set instead
  of two distinct patches)

[1] https://lore.kernel.org/lkml/3531360b-c933-4c5f-a84c-17edf0592519@linux.dev/
[2] https://lore.kernel.org/lkml/7d703c4c-1a24-4806-a483-c02efb666059@gmail.com


Previous version:
v1 - https://lore.kernel.org/lkml/DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
   - https://lore.kernel.org/lkml/DB3PR10MB68356D7CDF6005480BE5876CE8DEA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM

Yuran Pereira (2):
  selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
  selftests/bpf: Add malloc failure checks in bpf_iter

 .../selftests/bpf/prog_tests/bpf_iter.c       | 88 +++++++++----------
 1 file changed, 44 insertions(+), 44 deletions(-)

-- 
2.25.1

