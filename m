Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5855796C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 11:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiGSJyi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiGSJyh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 05:54:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B928E3A;
        Tue, 19 Jul 2022 02:54:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8a2RG026646;
        Tue, 19 Jul 2022 09:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=VoDcM9eI8zcCKYnnllfF1mZzEJJwa6wFvYEy0SNO/to=;
 b=pVpuh5TaqZwbtQDOl7282WP9JXRXcw6kFqoRoUL6RIhBCwONZITbnEc7Oy/nYMoqd67/
 0gU2FatCBsHqVvMoHtDVfkcqzWhrd9jC8Gj98jQlhb1GraKW8Akyx3VTtvZN9/J5KoAW
 7U06N3ch14XPPryuaZJjSXvcXhErDAuavGecagsOtYOP/GhC3JRjS4vwOQ7gUuAeG4qc
 KZazCtTCmQhRIyrS3Hq3Obr5uO2lOEnpMJvxYZoXR3r/j9+EDH/Fj6Z89UKWR/QoIndM
 uMa5k0MqpWwJkmC+RZxwPNzbbmr0544L874wwFjS7YPKXU3ufUlmfS/RveXhIzq/Rj94 pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a5pff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:54:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8a8D2002756;
        Tue, 19 Jul 2022 09:54:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1maynhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGSY6hrP+1+VZC5kgl6OwGng/6Q3zE05PYC8CS0cLD85+9kYyQtfTvbEtkzot8svI06AGZ/vceY37C04DJ2EIxSN30PZGcsel4HwEQiAtxVnG+HgYKuFPSBNr3W5kynzYLvAxriSDHcyQTfmMKRCek3BUizbnb8GRiEgIb2sA0sQzJy2AONkxFi0UZx4nlSlAwhGpNn86pO7e9IKU0vQYxr20z4ngvB7cM6dEbthkdgJMgaNyPxfZIFi2KYY2F7EgnnaKQAh8jLtjcIHGmi2cRsMuFPntp+yEYfFTcvZNCGj3XVrC8Ehx/ZOBmDG3Fnnio7df2ikcL62VWPRZU5FKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoDcM9eI8zcCKYnnllfF1mZzEJJwa6wFvYEy0SNO/to=;
 b=OdgzYoVzi/O/hCw4kc8UrLh7+1HEDJaL4Km4ppxA7whlrjguzE2be4izsrSvXhEdgVxRTV2cBFI3ixmoiEDYwvAp0bREdUdXnPUCay85ZZQghptUEVIu+ePRHAEyFbuWey8z1WMJF9MjsAyL7F3aKT/bIv/c0GbcLInazA9ZDQrF5Ld2iPUK+fpw1st8Jyrhj56vkWeDYBGbNRWjAqaQ911vlrQnNcjpuf6Ei7mHRZIBfJUZH+uZPuJTaWztbxi/AbCwaR1/5jgAvenVAaBKFZQyiIZvG3JZ0Lxx47NnEQfS2Xp7CTKWXiSyd0y3CN8Ffnta2ZC7mSznrKPo+GXnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoDcM9eI8zcCKYnnllfF1mZzEJJwa6wFvYEy0SNO/to=;
 b=vGtxm32zo7z/B3ecJSLL7pK+RxCCVYL6RDn1XP8E32TXrVuw0cg1FZj7I4oElI0EKMwOL+QXIDtNAtRZKlHQZApXb9vnGouVzZHawpVij3zP7e+yFnwPz39IrwMnxBmIIS9fGsQFjLpgT0z+InP8r3HLn8tTOl3GBxFMVU5jZUg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3907.namprd10.prod.outlook.com
 (2603:10b6:a03:1fc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 09:54:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:54:25 +0000
Date:   Tue, 19 Jul 2022 12:54:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] KVM: selftests: fix bit test in is_steal_time_supported()
Message-ID: <YtZ/Rnrm8Y+uPjDq@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0192.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55d36750-5b78-4f40-5946-08da696caa0b
X-MS-TrafficTypeDiagnostic: BY5PR10MB3907:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yj/hHAPqV2XfvOsLX1Iki/YkT6VUm9dboaFGFlma5/Wvf0ZtaBTFoiY+SoBAQU5ukWnk0/Vi8VTAUvPpoOtEfpEeGYP7vIwH+/z4MvdL2qyWKByLF2FSO14DwHH0R2zqNO2kljeAdZSPkzB7RmHI72ERe522dvaWiYJZn7JEPXR11z2Wb2F0RzK72l0trxxE4dLbm1cXj1pA+OdizkVdUxazLW645bOlpw//8vaq6NCBWfzgO1RWYMSpSeEmNO+nqOqw/6PcIpwlN+D18kdGB4O5YvRHoDPEyvr9OqItowHx9dh4sX3HzqrnPgxV5U3bCVgYxhC9qq8AluQGCAUyo31qYftZ2NhE1i1RrhBkrdyAogNtpXaF/sWDc2sLF32EZ8GVDxIXc6k6zUYUNk37Ki7HaBefKGbZ43AWgG0DkhdjcC/nQDE8POpZEDUQv2kpNdjBC9xZC6rNeVsFNx5+nlqv6JrDyqm8lxzwJ6Fp/GTAbr3dhcAkCG2Hb5Wwkv4BBQfAgSAu6x54B41Qdx0gHK8ax38cPcLGyEwRraGVGiNZQpBXjtokKxBNV2jiswzAnOsbKIMU7Lqd3pbv5kH3k94KpvDO+h3iF0N6KFCITOoGeqY4UeRQP77seZuVM5CZksfXA51wbMEu5UP4e2Vxk80UzbKbd+3U3ZrQKF9yY/tLjh7KcyZViT/4AvHCuaGfHeAb1H0KaZvTCnEZZA9Hv+jjooCd6AndO/g8B/YqpUDkDeHhOVwY7SMRMKIYrQqKvnFt6HjsK2naCYQ3mGmyYqWPfaM50mwbgyzsNjsx3is=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(396003)(346002)(366004)(136003)(66946007)(478600001)(41300700001)(6666004)(8676002)(186003)(83380400001)(110136005)(4326008)(66556008)(6486002)(66476007)(316002)(33716001)(5660300002)(4744005)(44832011)(2906002)(6512007)(9686003)(86362001)(38350700002)(6506007)(38100700002)(8936002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WosP+ZCVVrM1F+/X0T2iun1T7xa2JnqfW485j7sBxjGFZ6O/9imXzZs5Z3pa?=
 =?us-ascii?Q?pkFpvTBIcJF0KTBhXV318N5VxC0R8RzaIbVB7lP86ojTajkOsux2SqMPRnbG?=
 =?us-ascii?Q?R5FEzx7SjdjMFDkuuUwK6OWToicHLmO2gV2BBhzobJB2FbFQng0iuA7m2JTk?=
 =?us-ascii?Q?8WEF6dEc5F3/MNs2o6K/XE1Jy8GM82lKl8/PZMRS9liSvrGVakPZc5WsNU/l?=
 =?us-ascii?Q?s85W1k7HPSL0eduqXHWudVeIYr+dYexwWDv8bvwXJlQTmgElPxojqeXmJQmr?=
 =?us-ascii?Q?LooSCj0Nd/TBvO7fkTQgo0uXN5KZ1lmmD8Fdidu875j2wjfYKt3y+vfK6PTT?=
 =?us-ascii?Q?/T+QQJk9iVB/Nh3BtgYp0yOgUb7uggVx4Ow+2IwfZyMtfNuspiXd8i8jmDUa?=
 =?us-ascii?Q?N5BhUgMLWLBMLceNKCf8yQy2TrZnSe+YXRYbqoQdhGyyziekwZsjJVLpI7tK?=
 =?us-ascii?Q?MrG0bDA7wLdCh+NE9R9t+uAKKhAVUfDrIDDHfalwJBrZ2o7INKFlS9zSVqi5?=
 =?us-ascii?Q?uUVjrMCuMq/pxSiZBRLtPzHnyzVVpVK8j9M4PWk0EyF0Ts2ZgcY1Xk4PMIxM?=
 =?us-ascii?Q?csQsZY1u8SUNz4zH7+COLMHm57tylVYGeVwUpgAaUlcJeYI/RnLMgi1GhTN7?=
 =?us-ascii?Q?znHR9LQ5ORYHLdeE1HRb9fdGuIV4KcLjbavTkFqaxKy6UBpVSY4PJE9b92gg?=
 =?us-ascii?Q?+zSwI7JwIqvPsko74AUbhALf6PbH+68d/Zqy3JDTYvN70dxZ21yxfxa/Ji0i?=
 =?us-ascii?Q?BBZMwpWE9oxppkIBg1oFe8h7vztoc+2JtL3Twa5asJ3taTAaqrVyY/dwhVE8?=
 =?us-ascii?Q?++o+h2I5zo68vzQJC+PyUPXJfx/mGed0JaIvKfSXQcO2/nXV6rfSC/aUx1XP?=
 =?us-ascii?Q?mQ+dnVM7sJwVk9fyS2O5+KoKNfz5/3qMr7Aw/2BG+0/FqUzCZcEkCeIoeOLZ?=
 =?us-ascii?Q?TfbIhC1UiOnz+Brnkm+Tohas4t85gfXY1LVAnJT6KKd91XkaEv9ZV86WE31G?=
 =?us-ascii?Q?aYoy0OLcwaUNGQkTCOi8nFq2J0puHeojja/Ru0OHhJ4m0DyttQLRqY6Om3uO?=
 =?us-ascii?Q?4tIx/EAJWcSOm3DY2+yuR2o0/cmlFJb1WAHhEJwRCeadUjMr5ZUhUpjbj/2T?=
 =?us-ascii?Q?/C+LSCep8Fi+8opCt/Q7xj+flXSidNcWR7BVe0+hiMB8bHZu4mbCNY10IiXu?=
 =?us-ascii?Q?MDFi+2bV9gbozxIYrwxsHHa4CSi64jmWoEdyoN8FQYY54a+Y0YHDp7JciS+b?=
 =?us-ascii?Q?hvJxh/SHOvDvEWcm10TA5yWBeSEK+F4igNqj6bgRjJXbU70e773q23SoZTMe?=
 =?us-ascii?Q?SoM5Fs3XFk2ReTPr7sfY8B51+L9Oti1dI75VEU93v4ucsQVGLJG4lS8k22Mb?=
 =?us-ascii?Q?fpWtWir7btPE37KnE1ct3sFS2YkUR4/3Ksa+6x+uE7PQozfRG3EwQ73XkzPL?=
 =?us-ascii?Q?NKAGGZLU2mWhjhKEoqH0FrkatIhZwcpBmZAKUSBjFOTA627kTro5IwiNRBF0?=
 =?us-ascii?Q?VbuKpsZgWOe4eHh7143mjYh4DMHXPaaDq4XGCLvkZo1ZXRtjWXSjf57P+9k8?=
 =?us-ascii?Q?/Lo8K7yjNvEw5utTCC9DkdZuduwLDM5p+qt+w/piuQLLh3ft8+DU+brXmTTJ?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d36750-5b78-4f40-5946-08da696caa0b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:54:25.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T17aANnsZhnoNbba4DqXdEBQjeF+8ubmEPmP2XvVJayWLAMeaeWTwkjljwhe+kd3gESXoh2w0RpgywuS9ehyjvl00rDy4nS4V+5E8fC/C/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190042
X-Proofpoint-ORIG-GUID: 1rNlqMcBWRslqOvGKRxqrN_H3ZHTxR1p
X-Proofpoint-GUID: 1rNlqMcBWRslqOvGKRxqrN_H3ZHTxR1p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The KVM_FEATURE_STEAL_TIME (5) define is the BIT() value so we need to
do shift for this to work correctly.

Fixes: 998016048221 ("KVM: selftests: Convert steal_time away from VCPU_ID")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/testing/selftests/kvm/steal_time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index d122f1e05cdd..b89f0cfa2dc3 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -62,7 +62,7 @@ static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *cpuid = kvm_get_supported_cpuid_entry(KVM_CPUID_FEATURES);
 
-	return cpuid && (cpuid->eax & KVM_FEATURE_STEAL_TIME);
+	return cpuid && (cpuid->eax & (1 << KVM_FEATURE_STEAL_TIME));
 }
 
 static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
-- 
2.35.1

