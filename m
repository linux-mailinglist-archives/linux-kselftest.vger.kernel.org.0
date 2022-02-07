Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50564ABF99
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 14:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbiBGN1m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 08:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447122AbiBGMzk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 07:55:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0934C0401C5
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 04:55:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217CnLoB030403;
        Mon, 7 Feb 2022 12:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=kn18y3xtRaN64vxrwc7lwhHaRapKnj41eEic09ENWi4=;
 b=TLUzNKjG9v93o8/MlS217CtgwniBf+Yq89ePwXLJZyKcku/HSuV6t/jxolGvm33Wkk0N
 6McjdqBQBUAq2x1nebNST4+MFNYJrhZUrQjBXE6pT1wz7g+dH2HRMOQXyH7ECuJSg3ds
 7y/Z3kNACwgAW4wuztjO2fIODYLf6gRKMNWex+HM3rLTHoK82BfP/8AIqzQDpqNIz+T0
 JCMw4KHwtNW/fll6USh9Fu3WS9gZdKEQV/5+vyyYJgvWTzFtBWK0XfagFxwfSkYu6Twm
 5ZhNj5LMjLcKzlyubR7Px7od8ot4hVC4wAFXJQEsI+41kv/mV5jg4Lqbr3WlPuxk2EG4 dA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1guswyht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 12:55:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217CpTqi169214;
        Mon, 7 Feb 2022 12:55:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3e1h248q0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 12:55:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ88pFVo02AvyixlwRmBz91UHVjLSUJ+Pz9KaBFd/+Q81MglQ2MrM65lVCDSmNjWJ7V44m6jM4L43BAlHI9q1PoEYAVvC4bvI6fyY06jUq1hnCoQcVo7znbufz3BhvdZs4H4EUmYClTewQs5WMJwDZcZqD2+YfoBkKBhuFRj1k4M3+0E2nFBydHA+MQRoZaYDfIZWKFGB1vyrENvrdI0sCsfRLHQzMLHTB33KoI3IXExdQuol0sw3KnYg6CHCKbBnCO9EMCDEnVlICOnf9Zx/WaEoq7WdNLw8nJOlbs1eutE+h4NFo5opY5f7wmvYNok0owX/D1rz/BD95MQ0EkWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn18y3xtRaN64vxrwc7lwhHaRapKnj41eEic09ENWi4=;
 b=jPS+5rSw0ZLsdFwsBt1mTNHUIDm1+rltXT11hXWQ3TcLlLXdDqpcZO9FxFxmyc4NnX8LpBx3/Lu83ll9h9WVPP8ksky1PahCPi5iWm/BkK2RP1/vLxWH30BuKmMu6gEnA/E1XSxHiNbDaDTn74FlHRTqy+N12dkUsaDy8Yu7Y/WaZh5Fz18noJ1nTu/JNDVxZzVA+fpLXUDeYXh+Q6zAqS0nGxy8/PMpEvxGqnMvVlbdUKfLxHTgnxLT07ep9wNfiIMWDdUQCSTKkHk1DeN8tIACSk0CiDjlp+nkbn7cO9BRDJ+tsWn19t3pITj3B/QJtGyKDtkX8GXqolvMHRS7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn18y3xtRaN64vxrwc7lwhHaRapKnj41eEic09ENWi4=;
 b=OQZhNERy/x3YSKu4bZlO6F6zeCw60JfawA5rOzonxaicsb7bauP1vypqBzw3ATCKHHwZ86Ss39G5yk8dIFXFHon6t3b30cXfSYE/BUUsp+tHxdcdReavmKEWt7dEGGLARabnLIB+EtFMQyNUbQ496t0to4NZxIakZlKPwyIDJkE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5329.namprd10.prod.outlook.com
 (2603:10b6:208:307::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 12:55:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 12:55:12 +0000
Date:   Mon, 7 Feb 2022 15:55:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dave.hansen@linux.intel.com
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] x86/pkeys: Add self-tests
Message-ID: <20220207125502.GA20855@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd3c0ad9-f905-4963-bcbc-08d9ea39140a
X-MS-TrafficTypeDiagnostic: BLAPR10MB5329:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB53291BBBF01C1CB88F08D8818E2C9@BLAPR10MB5329.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3F6vDW7JODomjTQtd7HHPhKh7HAoB/lHWC2l1Y85LhnB0L9xD0QovIchFjbHKUUuy292tg8R1NmZ4OUb/0+2+yORfSWa1zQuFyzgrKhsWa9KQAkA/Qzsd95sqLGusIhQiaWsNyVEBGT1NTcUGHyIA4D3HfHZ4T9qvXgcuLztaasx3d+Gf2r+B2VOr5ot2q1PEwJgS6pa7ArC1xwPDNkL/pH/BU6YBh7rLrar2VxyanXMrRc6HTdgJlPOK0TbmiNxokUzSbQMX4CuXfXagyN6P4N3ZY/tLGCoCLNrXHKWtYjxtDJ3o3UZVjhPfbXLuqgm/a2q1GZp0B/trRrsBPIEGYsd89mWITzd39OMNLk5SgfttCxLOR/uqTf3hU3MOsG9e8XeRrkUJCTVSYWmG8UIQMkgujnp0i1wsBCbslgN2NKrBlrUAbAEoJpxjRAKn/HlGo7tHI7Y8x8tO1MPiObgC+gen9a45jUq2Kf/QyAr3d+SM9cfloIO04A8RxSnMuoW/fIbI/0poDOtnnF8IHJRvsxgB2bwfPMRTzltOXTbUFHcWb7+ZIbxDrBO3tcySYaAti9+FhEVyLt1s5AYxifl5ivRdUUiemcBxmqADjII8VQGEdHKsdWuvNI/gpPIIz2YNF5WLwtYSg3eg/pNJWsiqajHtKeWD4ei6eyNzNEVj570YnBpEumS5I0m6AYr6FbO+E0SySCwhmFd2NWYfsmPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(38350700002)(38100700002)(66946007)(8676002)(8936002)(4326008)(66476007)(316002)(6916009)(66556008)(83380400001)(44832011)(33716001)(6486002)(2906002)(5660300002)(6506007)(6666004)(33656002)(6512007)(508600001)(1076003)(52116002)(26005)(9686003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsxhD7jbysKqcOgRS/gkHGemzdOJMw9aiOGJzPtnz5eMM2hmjb3g8ZrG0nyS?=
 =?us-ascii?Q?fl+RKs6aEaHZn/yFD4gscSHTRQOOYpjNP+36p4rzACfrfkPAZN6L6+qMiZfL?=
 =?us-ascii?Q?95scKo04M49Gf4X81WCWNPpCVL5Hw2x7mesH/ncGmR4ZsFfemnFRi+Qejd0u?=
 =?us-ascii?Q?2OUVDHYwnAU5sRqckChlp8o0DozBQTscSkuakeSdNMs73U8Ro13nfmRXMeNx?=
 =?us-ascii?Q?iOXcVl4cJNxo5PHla5e95BNrrD5cNc1VxMpooCvwAaIFOXmKybUhfFokXB9v?=
 =?us-ascii?Q?Zjjla67YHHBjIawXrPLPougAUTO/KWry9TQ81K5+9BrU6XMv8Gx0YnYwyHZr?=
 =?us-ascii?Q?6AILKpMF6cH4fQSi8AunqMj+9su0UoDKYIxc2qGJsJji1ZMCBkLRFzTDl6eo?=
 =?us-ascii?Q?oUXM9ijWRnQyFDIng1u/zkG28ZkHk18NbN5a7OA1DfuJwbBdAVw7KmW+TDIs?=
 =?us-ascii?Q?+AdnZjISVuQUrqIwltC4UiqTHyZE1UeorQLG1l9wrNmNp39aurYC1lHU2JDj?=
 =?us-ascii?Q?5yF++tuelpiOD2JWrHdRkAajZTpbgeZ/+5yHKRFkw0OTGwbA9l77SC9tiIJy?=
 =?us-ascii?Q?4/1dUecunyELqrx2CNtIncL+jTjMzwlZutWrk38LiRNCs2S6GpPMczB5ymic?=
 =?us-ascii?Q?Hnfnk7nXxKaV/ykTwekwMIZ0S0ZrPFaLbmFffMjFva808zsfjyj+RBgnRXBU?=
 =?us-ascii?Q?j35QH7YwgZkLKtMhyQdGgOtcpnQTiezFqXRl/XjGkjhJIBSENtS84VHkBF9y?=
 =?us-ascii?Q?grTFe1hKiVGw0NXuHUumhhEYpe9cASPZQrr6wFzvb0XBz83qD89VPfgzv/pJ?=
 =?us-ascii?Q?6vCUs7Yzo7OI00IAPa5lAcyFuMfVVZb57BAn6o0RDllVniKIF4t1IGVltP1g?=
 =?us-ascii?Q?wEPNBMrfSmPjfBxETpN/H3ce5+bxa3jhJzVmbd1gyHA1OMa2A52XA9Ab3vJj?=
 =?us-ascii?Q?5+aUN9HyDfTXiaW29ZR9WIFa/7lSiECilBioWqTY6R6iWOcqqkny7ffpPLE6?=
 =?us-ascii?Q?LvpV+mUv/gLXF2AFxZ3sPTN+w0aEHm78AWZOcOBxAlIXsJT/hQdw770kX6gg?=
 =?us-ascii?Q?5pvRKoKpSmjOqdyO0ACqE2hQvqobLOQ/g9RVF20zDArrTLml6HIi3JGZpkYA?=
 =?us-ascii?Q?L1pAbaptRQZt/HABwPgRAHBWGrh7EtHM0BmXgq16KV3XQIS2UrLoY7/iN3Sk?=
 =?us-ascii?Q?VMmn27OGpVJNBPX3Fh4586NIbyvtxLjWY6WhryqYUFmjFtqmElXgDBvn4w3t?=
 =?us-ascii?Q?EKcAE1uTjz40NAkh2wrfZOlyG6ZXwUf6Qo/kQqqvLiKCehfXtKW5Hc4jIPaC?=
 =?us-ascii?Q?ZEuZ7AE5E0wWvFdQDh3bAUzLk2aRyULiC3MwdGkNqz/K8brQuEBa6K+gj1Pg?=
 =?us-ascii?Q?1fqwEjedKywPrpx21XUY/0zXpuRoNydHMtLb7qtLQwY+SR5r+zp/Me3O6Yl1?=
 =?us-ascii?Q?KwzebgfodeVFYHyMYin7AwijZEfizTyecm0xaYcLXs9tQwWd9wPRAs8ZFTrz?=
 =?us-ascii?Q?C128xzPxlnms1xJWCpAqTcVJWRXSKBptaGKfs0zTA34xXwUarlxWND2++tR9?=
 =?us-ascii?Q?+sGhffNhwz5r807rzCFrVyLdgtgALFNT/H23z0YnVjj/1xI997fOxLFf/7DX?=
 =?us-ascii?Q?iBHou8nXjbSDt/ujuylvHerUl19xFliI5URY5/KpaK9NqvtFJtoDEo6e0ZSi?=
 =?us-ascii?Q?2djI1w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3c0ad9-f905-4963-bcbc-08d9ea39140a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 12:55:12.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /u28HHYLk6UHXQeUG1Xra/7I3VBATgC20ZAB/0RhmKfAaWi3kjqJ2SNCFTAXz4VaK53RLR44aA4FdUhzzb4nUJnhJHkvUheDtIDJ/auibhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=817 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070083
X-Proofpoint-ORIG-GUID: y6kCrvvZI95Ng63Q2h-Jt2kTOeYgJbK_
X-Proofpoint-GUID: y6kCrvvZI95Ng63Q2h-Jt2kTOeYgJbK_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Dave Hansen,

The patch 5f23f6d082a9: "x86/pkeys: Add self-tests" from Jul 29,
2016, leads to the following Smatch static checker warning:

	tools/testing/selftests/vm/protection_keys.c:647 record_pkey_malloc()
	warn: address of 'pkey_malloc_records[i]' is probably non-NULL

tools/testing/selftests/vm/protection_keys.c
    638 long nr_pkey_malloc_records;
    639 void record_pkey_malloc(void *ptr, long size, int prot)
    640 {
    641         long i;
    642         struct pkey_malloc_record *rec = NULL;
    643 
    644         for (i = 0; i < nr_pkey_malloc_records; i++) {
    645                 rec = &pkey_malloc_records[i];
    646                 /* find a free record */
--> 647                 if (rec)
    648                         break;
    649         }
    650         if (!rec) {

This code is supposed re-allocate memory.  If we run out, then allocate
2x the memory.  But it only works for the first allocation where
"pkey_malloc_records" is NULL.

For the following allocations it will just select &pkey_malloc_records[0]
and re-use that again.

    651                 /* every record is full */
    652                 size_t old_nr_records = nr_pkey_malloc_records;
    653                 size_t new_nr_records = (nr_pkey_malloc_records * 2 + 1);
    654                 size_t new_size = new_nr_records * sizeof(struct pkey_malloc_record);
    655                 dprintf2("new_nr_records: %zd\n", new_nr_records);
    656                 dprintf2("new_size: %zd\n", new_size);
    657                 pkey_malloc_records = realloc(pkey_malloc_records, new_size);
    658                 pkey_assert(pkey_malloc_records != NULL);
    659                 rec = &pkey_malloc_records[nr_pkey_malloc_records];
    660                 /*
    661                  * realloc() does not initialize memory, so zero it from
    662                  * the first new record all the way to the end.
    663                  */
    664                 for (i = 0; i < new_nr_records - old_nr_records; i++)
    665                         memset(rec + i, 0, sizeof(*rec));
    666         }
    667         dprintf3("filling malloc record[%d/%p]: {%p, %ld}\n",
    668                 (int)(rec - pkey_malloc_records), rec, ptr, size);
    669         rec->ptr = ptr;
    670         rec->size = size;
    671         rec->prot = prot;
    672         pkey_last_malloc_record = rec;
    673         nr_pkey_malloc_records++;
    674 }

regards,
dan carpenter
