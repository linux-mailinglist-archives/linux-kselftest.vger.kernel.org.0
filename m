Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BEC53B9C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiFBNby (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jun 2022 09:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiFBNbx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jun 2022 09:31:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320566593;
        Thu,  2 Jun 2022 06:31:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252AIrca031793;
        Thu, 2 Jun 2022 13:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jJlxZ1RUcXSocsE+nEdXRcVgxIV0OAX5p/xx0f22PtA=;
 b=vgdx2VgrLFvj1jQ5xOHNnc8ntr5Q/3pQM7awCOQ+TAHQCNh4w7Agal8P4EDiaMQ8QjG3
 yTOH1dTcK5tg1jAP49zbt/AoCaQLnFG02L6LDerR0heJs/WqnE2VWva6NPQvacvTXGsA
 DTKrVt6wLfPSEqEWLZ0AIjesEF3mNWX+3r5xewyCaVHMmYxBslN0OKSMoGMBIyZN1I/O
 +YK6DXvMNAWgWat+lQLIz6TWRq/eTQPxZD5zg6sO9D9SdVdVcDFx5kl1AKDKyHYFW+c3
 QMi9x0VnV72v4HTZqfQ0tR4nt7AYNOGiGdmLn0TI06iGRHeCttydamltgM/+WQCInNcV NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xtgxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 13:31:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 252DABRA028995;
        Thu, 2 Jun 2022 13:31:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p4w6n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 13:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLFfiKyvAU1CjPWjRidhvFflnVMLr/J+Q69tzIrd0AyyQLe78UheKkU9RggZB4QJ/uWOScdkcIjswnpsnFPCq3oM9DudldXn8vVf107/YA81ZyoXIDoZRlBreuq+cXhXDSk4nNqhQ22jOb6XF/tJA8KQp/tqavfXpvmz/ESvwMGTPBEZrOTNyAphE39B5S0qPtrjh6u6u95ECTXij/PvwrJzhLpwD3rfn/qrLHlDFTQQAo5/u0GpB4xVNLYXyIU1WM+sOh4cihR1EldNl2C8y0/HakrtgcKXmrz9V10JVd5GYipa/u8MA7Jyuskn5hNy01l0EvZL4ZhTFfbmbH3Z5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJlxZ1RUcXSocsE+nEdXRcVgxIV0OAX5p/xx0f22PtA=;
 b=bruReeD0ZFuguC3BD7v8+QSxrMKBE+/L4ptNwZvGDd6gxjXxjlTUbjTW03IScm9pktLv2oRlNoXqdm0Mc6v/CAjBidq9A7V0hwtDD6HzTogaDAz9LWtSdlPY21oXWl/4m19iKYl4T0y4jeWet5LdTtONcD0vzM2Rj86uYEBMffD0EjPQK/80h8nCf7ywJxryIuof7CLL/rxap9xCbUJWHXI5cyO4s/x4ejyQ+Wc1payK/2RPk9ye/pXkfBh1ulqkOK0Spzn4rnhvrRkxqCLDm11LHjuee36hbL4cjMFKMOtuOZmJ5sjcugYacwQQjBvu+mBch28ZeeRbpgvykfPbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJlxZ1RUcXSocsE+nEdXRcVgxIV0OAX5p/xx0f22PtA=;
 b=MRtgh3atbwBh8n4ZfNdZR3sMR7Pbrz+67hEWkrL7de5EEtLoXr/IT8t+2VlNpUDtBDyNnItA6B0DkOUN8n+gheX3DcSLcg/AjcEt8OjdCoiAduBlpVv0Hlg/P229kzyaFuJRKQvNj8B916gSx4efd1zXhsu5FD0Sx86jSRw+JjY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN7PR10MB2706.namprd10.prod.outlook.com (2603:10b6:406:c5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 13:31:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5293.015; Thu, 2 Jun 2022
 13:31:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH RESEND v2 1/2] mm: drop oom code from exit_mmap
Thread-Topic: [PATCH RESEND v2 1/2] mm: drop oom code from exit_mmap
Thread-Index: AQHYdT4h7tluDpSgqUextkGGUA6Px607FNwAgAADF4CAAJhoAIAAb0CA
Date:   Thu, 2 Jun 2022 13:31:27 +0000
Message-ID: <20220602133121.p6uytrcde3schym6@revolver>
References: <20220531223100.510392-1-surenb@google.com>
 <20220601143638.9e78c470d2c980053cc8059a@linux-foundation.org>
 <CAJuCfpHcPhDYTpLj8Vo+W9Q6KkWdT_BOTaEfJW6_PDCPx5kD-A@mail.gmail.com>
 <YpheVjLQj5ili7ZJ@dhcp22.suse.cz>
In-Reply-To: <YpheVjLQj5ili7ZJ@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b592b84-2e7e-491a-5b6c-08da449c3296
x-ms-traffictypediagnostic: BN7PR10MB2706:EE_
x-microsoft-antispam-prvs: <BN7PR10MB2706D0B7ABFAF49D77B7768DFDDE9@BN7PR10MB2706.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0J1JPzp8LTZci1rRFyx/FnVhTUPTDB60avvBiElz3I7L6UqXD1GA0O1+9atDWyxwA39envFugxW8g1HsyqrqaK3G4fhRBaytOTpIN+KNoqQWCFFvWqU6pqUgthrcasrte/l3+oAU5u6/tLEtvxCWIv7XxQpVqi8vkZ77dDRiB2rJx57atUtxtmGZJUvf+MLcJajv1MuX1v88PXit3VI6IDV08u9lrL5RuT8EOFv2H/bXmpHljGsY8iD6urpERJ6ohuLI9tPEAKTNfhokYCWRDdd9oEfzOx1AIBF0Kr3oL+KIYWqyKw/PgSJUBkxvTUhH32ol7BJMdV9Bk0wv5eXngZSfxLfmPYKR6G5gZ/6ziqHGmsIvEDscCtMltZqh6EsrSoD9pBGG99DrutAwp2xv3yVqSC0ef3/EdKBa9n0QnRBgLNm0bRh/TIuQEVC+W1LmjNds8POSADUHyQvPxS8RLMgJrFYR31d9XFu4TicC/00oJAFm65JsvnvmEE4tGuz7dq8LE9JCqfUGKJLHpUoFkGvXqgtsJW021EdHRd6c9a/EbZHtixoP17asAzSy/+48D5AZof+xUzmzARLAX/DR7JStt6y8F5WGjKEN8ThoFO76y7ziKcOisvOkYP/m61CuABl96y1dJck6YvEyablKD1amlHjr1idWdyHLYfushc5p4ykl90QZ7e15f7+HTrYGPRTwAlsIgGricIkLTyP7kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38070700005)(6486002)(122000001)(66446008)(4326008)(91956017)(508600001)(66946007)(66556008)(64756008)(33716001)(86362001)(71200400001)(8676002)(66476007)(54906003)(76116006)(316002)(83380400001)(38100700002)(6916009)(6506007)(53546011)(26005)(6512007)(9686003)(8936002)(44832011)(2906002)(5660300002)(7416002)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iGGBpTPd9YjbLjp0B6yWh/A4aIvP4kMDME4yzESOJWKqyB+7RJmlv7gxmazH?=
 =?us-ascii?Q?DMlNCyBjWKlKk4fQV20B2F3hCZOWIx+dhEJY6cNm1Rdsx4b61QjqjZz/XwwZ?=
 =?us-ascii?Q?7NFvZNzQcwd2utiziWjAbe1i7Akh5YXbwgwSVpMI9BSm2e0zirQ19uLT38hu?=
 =?us-ascii?Q?tk5ydj93cICLGMjvnsmthwqQtmgfIkCkbhx8g6gl9KiA91fC9U6Pgu17IZLl?=
 =?us-ascii?Q?O3THt/6B7PB5cQTdtgLa3vlZl5oN/D93SFwss30HwQQVl8kz6Xch0iEz2OtC?=
 =?us-ascii?Q?fOpPT4LzXfK+815x9KiGJiWoec1PeTLd2qUK6UceaHxPuxROo8mr20lSR0PK?=
 =?us-ascii?Q?v5ltPKlET1Hbghj2XqzshTRvQrHYKQi78YeAfbkAs/QjcB/LhAtShyYzZvAk?=
 =?us-ascii?Q?3Pbz6qPpLTUcxUrAz+vYV6bSPO4zCS72Qv7jwbXbAWJkqHqQLltz4FVvhQUv?=
 =?us-ascii?Q?7t8zfjop6WE+nmVsy1Robl8RGxBRH55UuU+dW6qGRalrVQrz6zztFv+I+BJM?=
 =?us-ascii?Q?pgyNVxtHMmXr6kP+Y7L7B9hF651ESK2n8ZWwjOsA19GfkQ0p9pzWW0Dzfqq0?=
 =?us-ascii?Q?wi+H/UpeXtPLIivf4p5eUVzAaR6ya4P7QG1KYn9xRccJcD2kLhwFyUG/Ebam?=
 =?us-ascii?Q?v8HZEluSL8+nu+9QuqPKScM8FNZp6nHM8VV9zo5lwv7Rg4J5IkZebuGjDnkE?=
 =?us-ascii?Q?Ty7XAIqIH30UpdmkDJkPB/zs99d805tYMaGaHMsCIUi1/g795DWTlsBT68js?=
 =?us-ascii?Q?kRO90lKOvZYM9p/ByGxc8uMsjizY9W4v1mfukJvmLU2LSsDG9I9J8HIPDwPv?=
 =?us-ascii?Q?OmmNf9zsAvSgN8KNBchK/5+gg9+b+529KvI0yy0GqX9qK0VfZJwzyh1Djm0i?=
 =?us-ascii?Q?mzAoK5wHBE5f+zAfXT1pZzmlp+jF8oPlHvC/Up2MBNoVNo3ej4cJNoE+vTk3?=
 =?us-ascii?Q?XjDYw0nfxYbO8gVA7d4qMpJ0aobPVaQaMPRNewDb10RczPK0kvyhrOn5h1MM?=
 =?us-ascii?Q?cc7QnEZEFVrz6yHNWOgEDArcFNB7l0dJ2fihMwrdNlUxoJFnp61R01u7BPVT?=
 =?us-ascii?Q?GEFpNmMBgMr5rcjYdXFC1qyLHpQxkMPK+7K1AukKY/96/uUYvK2QarxnOfaz?=
 =?us-ascii?Q?AxlRBu4Gu3rhyzX579ZEhy6VMKr2VvqrMCqh/O3Y2VXH3IrM8liQ3ak0YgbZ?=
 =?us-ascii?Q?t+gdGq59AQYIX23gD+u3i8DXiN9zc86PQWMytTDxj3ho+gNCqPGWlo70A4XP?=
 =?us-ascii?Q?5ISHnjcZ+26RaDkwcow1081DubrnKpuWekYaFjxQjKST3PaDrEtM4pyGkZ2+?=
 =?us-ascii?Q?GeuXjPHAY/N/qgPyEZWwS5u939P6az0qEuRZgisAftCQT2flVO7PyoVfEYDb?=
 =?us-ascii?Q?0ggk6QmV9HnSVv1GRFej/iZYCyjfu8LOTHXYiR8t+HpVAX82DGwTS1ty8ae3?=
 =?us-ascii?Q?cWJkf+YfVQSNFUl+C5p0aq/OeG0nrLNfDovN1TtNAuYXMPd8jXcLKi2XaAoL?=
 =?us-ascii?Q?tyGbxllBamv7OO6YOx4qOF7kiL5/2GsSt/FlmYkntzdNXYSJf3yAUjnsRPzG?=
 =?us-ascii?Q?B/o33Xm5apr0IgjDWU7CEqKIGmFa2dZMxpjnedpG8rTxfBVtbrKiAYAtIfMW?=
 =?us-ascii?Q?Uzid7jb0uNoKJ+hCB9v6Yf1m4dUfsSaYO0N4oCHnTtfBmI1/liT+7+NTjZWY?=
 =?us-ascii?Q?AhQNU8ZQHWEAyL8Z0nQVISSJju5DETRRwfQcpxY5WtcVTmYn8QHBqXAUI7jv?=
 =?us-ascii?Q?43Z8WH9C57QCN+OK5fKoKMNJh+fRXp4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5FF12CB9AF1A174E9C90B47C192BCD87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b592b84-2e7e-491a-5b6c-08da449c3296
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 13:31:28.0023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dn+4m8s0CF9uAng+27fyoD5y3HpiRg2to99aMHXso786LTohafEMvXRBLgJaXAEBdYsDedEcmYZ9FOx/uuisIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2706
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_03:2022-06-02,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=799
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020058
X-Proofpoint-GUID: lYWtV6AK5Q6wq2Pqb3VGGviCDcOEVjsx
X-Proofpoint-ORIG-GUID: lYWtV6AK5Q6wq2Pqb3VGGviCDcOEVjsx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Michal Hocko <mhocko@suse.com> [220602 02:53]:
> On Wed 01-06-22 14:47:41, Suren Baghdasaryan wrote:
> > On Wed, Jun 1, 2022 at 2:36 PM Andrew Morton <akpm@linux-foundation.org=
> wrote:
> [...]
> > > But iirc mapletree wants to retain a write_lock here, so I ended up w=
ith
> > >
> > > void exit_mmap(struct mm_struct *mm)
> > > {
> > >         struct mmu_gather tlb;
> > >         struct vm_area_struct *vma;
> > >         unsigned long nr_accounted =3D 0;
> > >         MA_STATE(mas, &mm->mm_mt, 0, 0);
> > >         int count =3D 0;
> > >
> > >         /* mm's last user has gone, and its about to be pulled down *=
/
> > >         mmu_notifier_release(mm);
> > >
> > >         mmap_write_lock(mm);
> > >         arch_exit_mmap(mm);
> > >
> > >         vma =3D mas_find(&mas, ULONG_MAX);
> > >         if (!vma) {
> > >                 /* Can happen if dup_mmap() received an OOM */
> > >                 mmap_write_unlock(mm);
> > >                 return;
> > >         }
> > >
> > >         lru_add_drain();
> > >         flush_cache_mm(mm);
> > >         tlb_gather_mmu_fullmm(&tlb, mm);
> > >         /* update_hiwater_rss(mm) here? but nobody should be looking =
*/
> > >         /* Use ULONG_MAX here to ensure all VMAs in the mm are unmapp=
ed */
> > >         unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
> > >
> > >         /*
> > >          * Set MMF_OOM_SKIP to hide this task from the oom killer/rea=
per
> > >          * because the memory has been already freed. Do not bother c=
hecking
> > >          * mm_is_oom_victim because setting a bit unconditionally is =
cheaper.
> > >          */
> > >         set_bit(MMF_OOM_SKIP, &mm->flags);
> > >         free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
> > >                       USER_PGTABLES_CEILING);
> > >         tlb_finish_mmu(&tlb);
> > >
> > >         /*
> > >          * Walk the list again, actually closing and freeing it, with=
 preemption
> > >          * enabled, without holding any MM locks besides the unreacha=
ble
> > >          * mmap_write_lock.
> > >          */
> > >         do {
> > >                 if (vma->vm_flags & VM_ACCOUNT)
> > >                         nr_accounted +=3D vma_pages(vma);
> > >                 remove_vma(vma);
> > >                 count++;
> > >                 cond_resched();
> > >         } while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
> > >
> > >         BUG_ON(count !=3D mm->map_count);
> > >
> > >         trace_exit_mmap(mm);
> > >         __mt_destroy(&mm->mm_mt);
> > >         mm->mmap =3D NULL;
> >=20
> > ^^^ this line above needs to be removed when the patch is applied over
> > the maple tree patchset.
>=20
> I am not fully up to date on the maple tree changes. Could you explain
> why resetting mm->mmap is not needed anymore please?

The maple tree patch set removes the linked list, including mm->mmap.
The call to __mt_destroy() means none of the old VMAs can be found in
the race condition that mm->mmap =3D NULL was solving.


Thanks,
Liam=
