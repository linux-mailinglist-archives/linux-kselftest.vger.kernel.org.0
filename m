Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37895795BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 11:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiGSJEp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 05:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGSJEo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 05:04:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066F311834;
        Tue, 19 Jul 2022 02:04:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J88JJD023354;
        Tue, 19 Jul 2022 09:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=rNrUAuoj1ti34pQBD5vu56PJlrc9nA/Ui8f2eh/i0QY=;
 b=O6rw1SnsQdCcne5tw5GS320uRct0hWtvMx+GoqYaCxl6Fq87IX/Kak7R9UbJFYBo2/lR
 9HNcyKGnscFNHMMyb9oPZ6lqZox4ZbaAhVfK2O/4viJwLeE4gYWF3wu/CmI13BBkqGaf
 uNlVOy8hRBJg0g0d+zrhwXQf/XdV3sUTw0RU7u/PP+wd3Dy+s0ClF7FGOOMGSFwm8vOz
 sT6Naa0b8dkM+wEzawWR106tCr3tf2IRXuSxsLZ8OnAkH/noa+dcfioi52K1sBxpVK/9
 sHulM1+Kj87POYE3rAwHz9Re1obADKyJhw5E8D41XoLmBSed/UzXGREbOtRnUXGxAZHz HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtdnnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:04:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8a8dD022146;
        Tue, 19 Jul 2022 09:04:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hrqk73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:04:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxsjeiyaoO64pZq9bl+eRip7B9R1gbjJdHxIfyHtTzByBd4CwNexIXrCS29VrA8gIxO/tmyqTSdV8KlIbaeAekTSYI75mF2UHSaBoODMZA3nEbaK9WqssfoPfbqmX+OjCOr9o7vL6nf0xZ0EDxUtCmbxupRQTECbcj10VwlPKbcTYI0qh5cj4dBP1aUKgS4hBC2hAnh0oyd9HvD8r0bqmXKofPD/t8cHmBrFIPH1W2OOQpEGvIaC62WX/L+buJoS3BxqCl57Wuc5SJeHTi/CpTFrQWLG/wNI5JPX88m5ynU2nb5lnrJqrc87wC4UyhXFCLGGaW867feXjhA7sy58jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNrUAuoj1ti34pQBD5vu56PJlrc9nA/Ui8f2eh/i0QY=;
 b=T2ofqJei7CRni30HC0JsdBipsEtb/UKN9jDASgp/jlxOHwGpTiHPX+7MCWnXzLQJOQq8uTI7nEFqDWRM9dML8KIbJPgcOuPfeTQlWAeriJ+RffGegGtuQrgg+kUaO4apxu5/7pGMgR1ODYg2/DuWcaejk2vkNprwhyrKWPwlA4SfOuH7nyI+zhl0sXslcu3anDYV5+N11OEOJPPyV6Y9qXxALkJhJe9VBMg/wwHlNyK9fiFyw9P4qkmP+92xPBu+YRsIcUVIFAFMqA4rSEdA9yDkcSK6TaYUaU1iuvVMdfg9MTjovZYuwsxpkYnMi7BVwtnfyDVOE/LGffc/t2u06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNrUAuoj1ti34pQBD5vu56PJlrc9nA/Ui8f2eh/i0QY=;
 b=Ob7S0ZmGiD8wgK66GyhR3o6NCllRb4DpZV0wbViQ+MJugFKy17pLjjDlgC2/0fM7JvhWjawSnhr/zrC/qsCye/x6GIDiJH3aaTbj2zO+OSl1qtKk2QhxdinNT8tmIBw6F2H4bmDJRrzjqcMM+bD0RwB8f2bSf40tV86tgXucEjI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1575.namprd10.prod.outlook.com
 (2603:10b6:903:2d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 09:04:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:04:26 +0000
Date:   Tue, 19 Jul 2022 12:04:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] selftest/vm: uninitialized variable in main()
Message-ID: <YtZzjvHXVXMXxpXO@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc8dd747-ff4a-4ce8-0512-08da6965ae09
X-MS-TrafficTypeDiagnostic: CY4PR10MB1575:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAm5vNjP5u8Q3nwLv+Pwfr7zPZihjHlBr6iyuaEA7IoCfpRBAn2d0kEGyyLBgshcieV2xIISm2da4KRmKoSBWiMCX/nTMNBXznJlFW4kdVDdZ57mCvQR8f4WgC6EkWke3J/sAO2dHyizHF/jXed3XO870IS36rQDQqHRH8t3ontWRvozSEUpIbLUrB3M49dBdbBEFJbUqpNiuxEYRnyFMkrfNt7igsWw5IiqM4ypkIendvXhT5nb4mlYp/vQxDEzYfHMHuY2IZR6z6TObuA7FivOr4T4faybEm60zLrztRflRmDecgO0vp5tv1r7JY/nZo0GpQ+xha9pANTM0gaCbvocnZlIpKsxRSE6n7XwesT8EYciKMKk71gb9kxIK3bGlsul2Te9yf4SfcFFr7NDTcOtyYdngrRmPo8Oh2lliv3Apt0i50Wn3Rs5OK04cGwhhhWY8c5ELyIcscYMFw/zkU6AxC5NJ+8FIbqlRzdWcaMdSoiJDaItIO5/0tav77RypC76UUrQEmP7GpRutVvKZxlcXavqPcTqUpRC5bXDbTkfPAo5KjcXbDqM2LhsFSdG9VLj038bHzp7VvsPoiullyoX+BN4y/mqSyp1zGX6TNU1Hu7laTS7s1D+HDLjTCfMca5c0HaulJ7SHgzdaPr3RVL8WPTKSrhhELYpCJgVnhc0FlR7q0vE1Ku5LqMz4E9GbItQow4A7/OfnI4xHdVDTU3BH/xq+RZsmozC4hUXEuJ5Y5NSwfLxZFTD68sjhlORVRAiBz9DZNp2rEt1/x6VVFC3VXnf4Lws74mVbjIu/TP5pcPbTuTZTFbgdhpvLoTU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(376002)(366004)(39860400002)(136003)(66946007)(8676002)(4326008)(5660300002)(38100700002)(66476007)(6862004)(38350700002)(52116002)(478600001)(44832011)(86362001)(186003)(8936002)(33716001)(83380400001)(66556008)(54906003)(6486002)(6506007)(6666004)(4744005)(41300700001)(9686003)(6636002)(6512007)(316002)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6nCZkBNzFwSptLyNLcPXQ3RuG2Fq2IUT4aEXxDrr7GdyEx0GPXKvDeF5chAo?=
 =?us-ascii?Q?2S9Fsg0R1WCaRM6voEeDt1gLivrsPDij6qDFotpbKykQbdbABGXunc2+PCdZ?=
 =?us-ascii?Q?R2TIy1fxOVJZEmrNGmTswyxkYggXWm2naTpCbmP1dLt4V35gh974WjSoOv1N?=
 =?us-ascii?Q?xCVn28YKUSk8S8Y1ZwPPpN2gqIbyz+BiTv+1W0Zc7m3cXM7kZTgeJhcOELK2?=
 =?us-ascii?Q?kNfZSDKu22iMrnrtU3dN2Bs9sR1mWt4KmEsdjZMiuJGVcECAkmU+h0TECWbo?=
 =?us-ascii?Q?HGRxIY5gIH4wpmmcMqKRlx4EgDAexJsdwetoqcoSccB4U2gdFATryeprwR9p?=
 =?us-ascii?Q?uE3x59M1Q0tDCc4RnFR4DB0JUMgOFGLeeveSlBy0jSoBNcw1pLGKjZiFznFz?=
 =?us-ascii?Q?Y5HwStmAChh6VjaRDb4+wTszcTrVYNFKi0thXZbfX26MhWg5LquVwB21YDwz?=
 =?us-ascii?Q?lMxh16KAT/+o+u7k1CaV4KEZn7zwGcv+akSQAEXdw7brlpXdD71NmT+28Kof?=
 =?us-ascii?Q?N2LiKV1gIu8dB1UomI2XEdBxDFG4RMRucDNDAQngQ0uQuIyCeZruyheV4R3K?=
 =?us-ascii?Q?QQW/XmTu3UXeWQZ3+qqhLv3hRVoaHxFJB3Wf99qwthZQHNQRWuNMXsASXHIY?=
 =?us-ascii?Q?dcCjPRaS0lZZuqWJDqn6kmPnSwcSTlJT7YWfHndsYFe5FzrP85O8olhZjS6Z?=
 =?us-ascii?Q?s6rmxyvN/jv61i4joKDxuzCHTfGb9yfZGsYbSN7sMOdD753VipIQZt3NbBrG?=
 =?us-ascii?Q?mWpUFtUB3wDH2UsdOhq4y5B6QvvGUFBMPjKQ3t7kLMxkYgaQM2IqlUwnQc1M?=
 =?us-ascii?Q?8fp7Qw319P20Ikfv0pzwUYzjHPFHNiBRLEaYQ1tKEJhmh3LorAuKxpoEN+qy?=
 =?us-ascii?Q?2g+EKEsmFW3f6FfkDzACUe9sFeK0xRj3E5g6TOqananeWlm0eI6g6bAVwJ6I?=
 =?us-ascii?Q?gFR1pGYGTZj921dnOX6go/TWwAfmWjgVny4sQfAIbgfyXwOxkVPCVdSkFbOf?=
 =?us-ascii?Q?l1J53DGCwmGu93rL2goFfPEDjIKq6qYtozHL852CdZA675rMMGrLDiJk3xnc?=
 =?us-ascii?Q?4Gd0lxZrX4wLm48c3TRIt5psSNkbd4RAhYm/Gg4+dmWzbEpov6fMd5BVBXGH?=
 =?us-ascii?Q?vdjF48i5RS46rI1bqHTzvgXU0bG0W321bOKHSj+6OomOLCVfJoldSQEkr9bx?=
 =?us-ascii?Q?5CQzpne0LlwdrnRqynj/a0mtFwY+yVlYhd79OaYnHf5op9dFJwOocOMGRfJG?=
 =?us-ascii?Q?7SdTggVJCqidQzqL/6T1NY7jYY+lKWt/2Mb+wfEXFt59VgWFl02LFNoDZ6hJ?=
 =?us-ascii?Q?ytcIkc2WiIEbYv1WhtJNBeErdSdgIcrfkAnPsmuflkUpwIUXKt+tmwlPZw/L?=
 =?us-ascii?Q?hkV/A5YyfD8ncs2wQJdeM3VW3A2V+UFWICGnc+gvRKX1VjPJOTClM6Y80+kt?=
 =?us-ascii?Q?+J9dmaDWSuUWZO12wgJEmMAPpLTpgA+AjnqrzixJv1DDvzsRm3vObiG+bNws?=
 =?us-ascii?Q?5ALWmKPDPECclRNoEmijLPmo7fEpIYuXOr96aATMOIzM6puoyCFzobQuwB5h?=
 =?us-ascii?Q?K22kLCFByig+snskmjITPtAGuOCil/iWY33xNMgonbUNpi6YmOfe+N/9yKoT?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8dd747-ff4a-4ce8-0512-08da6965ae09
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:04:26.0192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYgWsZkyzYec8JFmxXQy34JIYVLwJ6PLg98MEO/kScSBK8zy2ugkKGyY+sgCVKnPza79PpMlfJn4WulaiFvU+E79qt/Ih9a5fftYQAmRJm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190039
X-Proofpoint-GUID: goijkpmvq7RG75KkTVfZ-iLaNxdB2h-d
X-Proofpoint-ORIG-GUID: goijkpmvq7RG75KkTVfZ-iLaNxdB2h-d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Initialize "length" to zero by default.

Fixes: ff712a627f72 ("selftests/vm: cleanup hugetlb file after mremap test")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/testing/selftests/vm/hugepage-mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index 585978f181ed..e63a0214f639 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -107,7 +107,7 @@ static void register_region_with_uffd(char *addr, size_t len)
 
 int main(int argc, char *argv[])
 {
-	size_t length;
+	size_t length = 0;
 
 	if (argc != 2 && argc != 3) {
 		printf("Usage: %s [length_in_MB] <hugetlb_file>\n", argv[0]);
-- 
2.35.1

