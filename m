Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9A61FE27
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 20:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiKGTDx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 14:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKGTDw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 14:03:52 -0500
Received: from DM6PR05CU003-vft-obe.outbound.protection.outlook.com (mail-centralusazon11013001.outbound.protection.outlook.com [52.101.64.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578327934;
        Mon,  7 Nov 2022 11:03:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joxD3CxbdvtT9/U8n0cSDvZ16HlOtT5519Gs9qHTmYbodKBGmwf7+xq+KCWiiqm+l6NVJVXor3bK+13OBRfhBzg4jz8BPNW21SK6suKyctGqC9jgTqTMP+n5Kcz9MduAtGSbPSEeVoSDMdeG7r8Hel5uN7VJattnn+onEd+y2i4SehWfNkj9JVhrjMBDHoi6Yv/W86acSQm0yVe4G3TvZ/zH8uyY2dlfipepTJg4kDuTBHJl0jo8A+U7SzamzN/Y25hJZRXALggdxGKOHb7K2HXYKioXo0totlENAZiefRfrrBSz0WJVoX6FYHTYIRQFaa/1lPUlE60Cm8VTOVIl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMm1F9kmDsUV3YAItctwDvww/eBkRcX8E/vAlxrs7Qs=;
 b=HfI/6SATN3paV8BN8nmdBEsqqq2aqoluljRb4yKNB9u/AkgBfksalMKq2SuAUegbbj3B+1EYMujXIT44olNrO4faXy03/N60nWYYt1VW2aLUZUZDKbB2bfo3ayzS6KrOJxGf7nQasD7II8J5JMyvHJH4EkQkPEQ2g1RCh9NLUl/MN1Ahd6DlnNjG3XTTR8lmD86a34VUgEbBuRON7XZ3MqRtYhuwC21nWmBBo6URjwhYZuywG+qUTBZKcZoqYoegwMEfjSD4ZsOC6jkv/e0OcY6iim1VF1lPWdPYfIE+4qjFvhYc9WDuyn2E7enlVGqQpvooHAOkEXQjcKJjKoQNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMm1F9kmDsUV3YAItctwDvww/eBkRcX8E/vAlxrs7Qs=;
 b=nRS0d1aTB+odpfReEG9+bshqLvSaojXdlRynMOvwC0RceA0iqFegldKekhx3Fn6tQ49/kkluaTXuX7WQvIyATfwoMqGtjS+Y3+eesc9Z+Iv/5VBfdn76boc8S4kZyEmLkek1Kn4ERUM6qCHcOKZ1UwF9Tv589A7IeWv7FBQ1DmM=
Received: from SA1PR05MB8534.namprd05.prod.outlook.com (2603:10b6:806:1dd::19)
 by BY5PR05MB7190.namprd05.prod.outlook.com (2603:10b6:a03:1da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Mon, 7 Nov
 2022 19:03:48 +0000
Received: from SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::ca89:ffc2:7e20:16fd]) by SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::ca89:ffc2:7e20:16fd%5]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 19:03:48 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 05/19] mm: add early FAULT_FLAG_WRITE consistency
 checks
Thread-Topic: [PATCH RFC 05/19] mm: add early FAULT_FLAG_WRITE consistency
 checks
Thread-Index: AQHY8sSPsuqGQZcSwkqSjFQS9Nwjx64z0cqA
Date:   Mon, 7 Nov 2022 19:03:48 +0000
Message-ID: <E1E8C21A-EAEB-4FA3-A9B9-1DFF81FCDA70@vmware.com>
References: <20221107161740.144456-1-david@redhat.com>
 <20221107161740.144456-6-david@redhat.com>
In-Reply-To: <20221107161740.144456-6-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR05MB8534:EE_|BY5PR05MB7190:EE_
x-ms-office365-filtering-correlation-id: 58691cf8-f0a5-4dc9-95e2-08dac0f2cd1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4ZgqZJ/nZo+t6bBykyeqlDysQg7OBj666BnOWgLCZqpArReQEDoOOTAkXgM9HkAOmw10Pdv1miyNP82OyEToEOKp6YGCtXrM0gDBVDCvRd3DcfIMsYqIQWFGzwUorYMa4C1dhap2x/A9AqWHHhtvPlVfgGgVFjCiZMEZ8cJoQH/iBO1svyWLEKoLdcoPyy1olH8E3vj4MBcnBGoOk8v6Be5ZFVDFMykrKtpuvUcD+tBrDmfBTCMDkjXGukxrsiiZKYB56A9AEV6yYkxnhanjqPrT0WYNoY/Ez/Zmn04S/dikfX+tcLj3UJQ/QXM4FEppfqc2uBlqX4CKnkPCqi6LK5S0wOliIOFjQZmGPGUo4srtHw/pCxCg1SIHYaymNkSZRXz10nkcUYlCzeSKX64O2q9YYUT9TTpHPq5bJ+sLQgTSWfunMgmV9B7PmeXwygk2fOIhSSfjsOPODKSsbK++U/BMhqk92MPyG5++K+YjJUJUHblYfJpwIb3kLLN497zVy0jp+Ouk5q0N/8EW5Kpo36qhe1YFKaTQOfQi+O2V0HMn+TYGNFkqqP3VME2lz7aerDow+O9lpPTLh1ZQbvrgQSdc9llzO24bix/XUYsO2sV6i/a/Ev+vtWuac/py7mKD2h1YDdOWcoUvImWH0W9DtLpOxr/4ew3EsVMdt2vD752nMTv5AAy2iVAFPlVXlXBnDIgCswPQcXqTmHQj7hgwgyK8qMuV/3GidPPAN3LIlMmAETZRZZKsoZ2bkxI3sTQmqt9ep7N8twQLWTjCJOIqJB46scaEqrY0K7Gs14bgvQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8534.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(36756003)(186003)(38100700002)(122000001)(2616005)(64756008)(86362001)(41300700001)(5660300002)(7416002)(2906002)(8936002)(4326008)(8676002)(33656002)(6486002)(6512007)(26005)(478600001)(6916009)(316002)(54906003)(71200400001)(6506007)(53546011)(38070700005)(91956017)(76116006)(66446008)(66476007)(66556008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vvly9o6KLAbVhCRPuWL1UNYXFJkT5nQ9vNVn7m1WSzmr4vzk9DFzyOqPKiVg?=
 =?us-ascii?Q?xNlyZrLWR874tpGRpmcGQcobhw3/UJfS0FEcv+QthTazB0aezS/oafSaPhgO?=
 =?us-ascii?Q?y7HHRVlV+erEtN6/pjby4WX8JJkbdaCAFlQ9advIT0O+DX/SqytcAF3Ip03P?=
 =?us-ascii?Q?x62COCXsB5SVlu11nxcPozTGf7kGGrlZ3kzV+Ifthwewu3gRU94PlgEl33UA?=
 =?us-ascii?Q?qjQxJ8TDThJ0MjH3VvOaYwwj9iF66gcsM+/oZoyj4PVTRctKDfHqVgT68Q9f?=
 =?us-ascii?Q?SvmMx2wMtWIIZBd97QyE57DWs+lrFjY79CQCWcgYEAx5NkSVJ4w5jW9MSe3b?=
 =?us-ascii?Q?6Pujf9W8bMKeiYQVeFi/4TBamyWxqi3rzOrML/SwcClLEmfn1HW6DW93esR9?=
 =?us-ascii?Q?xPdTsiZjrs47NRsSV9JthzHcPDVwpSqq4+E44Opk5W4HDTZrfxhlrGIavy93?=
 =?us-ascii?Q?JX6MirHulSQ+umPEF4MZ/++ox+p9RcKi9PAwamENOnxjTvTdoeRk3UAxf6Ix?=
 =?us-ascii?Q?/fHAWIa0HKQ/BBlghdp/27a46YJofz39jbxb1i46ZUu6SEUDTekh9FAPkQDK?=
 =?us-ascii?Q?DOx95yKhQCkZqlAIzcynD08atClkFfZi2PvuzbdARe/5In3AP086Cdv/5uYR?=
 =?us-ascii?Q?nzDHuh7U1z5q/0g3FdnGzYVeBp3JlvXd5ZPUDm+Rag3ZCqqhC/yH5HUwPPG+?=
 =?us-ascii?Q?8GDHuKIZ5i0ptFhmT4d75Q6lDGCF48ANsp4HJszVVy7xtdAhsbvij+dZAtXk?=
 =?us-ascii?Q?B8vegZTdl24uJl3+4PCyZfe1G3TED3wYYI8vsebc5PmjcXIBpZOq43Dw/j+s?=
 =?us-ascii?Q?aDtle7uRCZdnhYUjn/CmtxlXFf1Z4WaN8Yzy3EV6Nb3A5uhdGK1laNz6zdOs?=
 =?us-ascii?Q?S1qP3tjgZM5Uq0flU5JBvwv2K9Su87kyZGh5jyAOtzyyo8rxqGB7NRRMGnX+?=
 =?us-ascii?Q?4tsUv9k4ifOA+K5W5WDB/AyLmqSi5jm2fBOLUvcWpo1bEJRHMqYCV27T89mz?=
 =?us-ascii?Q?H81DuB3KBSZL9GoZTn81qTkTkAdWVOupwaJMrk9I2dr03cCwRxkERa0A4TDF?=
 =?us-ascii?Q?RgE8YIiSGyNS8besmEHUpQWDMyJXrFKXCElcK8Z1R4+qZtEF7u4Nw9kAUjaD?=
 =?us-ascii?Q?MKR4gFSnxEJdZ/yRH8f3pDGU4/2s+5dZSPzUg7oIkTIXa4kk8ljcPkEmcExa?=
 =?us-ascii?Q?uZ+rY2PUa00lxia2gOXwrdhBO01X4VmLdS4uD0mCfqqF2x9K31i0JKJT29yJ?=
 =?us-ascii?Q?TaEotixZ1CqIKm6cX4LiFz78ZM9zP22TTtrWdjdkDqyDYpJx+t/bPk3aByji?=
 =?us-ascii?Q?NQOBmyuSzLcnAuC50Fvl7pvi+XodzLBSxhIFbH7FhmEKuQ720j+aLEnvU35I?=
 =?us-ascii?Q?XRd5kU4SLEH80r3A6Z7k10NmR+shal8RREJAa5NBb5h5ga1+beS74gmt4ijy?=
 =?us-ascii?Q?dtwwkeLkixHqWc4a5/i/S+cpHiQI4bXX4tws9nXyVymcsID4dG8N4beGKeHI?=
 =?us-ascii?Q?IDQNQBkGN4pzpm0ruFZWVbk6r+M9rtLP5MnPDb5v3U79Gmw9G+XdyTKhSD5U?=
 =?us-ascii?Q?6udjOHHxfJk8g8wI8KMQnJ42HQW/ANmAfBRr9YPi?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <936CE9F434A0C84C92D104C436CD7D04@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8534.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58691cf8-f0a5-4dc9-95e2-08dac0f2cd1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 19:03:48.1830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfSM0iTEhYfCVrJe4QTKrVUTq2AdsVnmQAy3rNSQzzpUbV1I6knQSA1bZfitlCjDq6rH6cbaztTwAKdz2I1oOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB7190
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Nov 7, 2022, at 8:17 AM, David Hildenbrand <david@redhat.com> wrote:

> !! External Email
>=20
> Let's catch abuse of FAULT_FLAG_WRITE early, such that we don't have to
> care in all other handlers and might get "surprises" if we forget to do
> so.
>=20
> Write faults without VM_MAYWRITE don't make any sense, and our
> maybe_mkwrite() logic could have hidden such abuse for now.
>=20
> Write faults without VM_WRITE on something that is not a COW mapping is
> similarly broken, and e.g., do_wp_page() could end up placing an
> anonymous page into a shared mapping, which would be bad.
>=20
> This is a preparation for reliable R/O long-term pinning of pages in
> private mappings, whereby we want to make sure that we will never break
> COW in a read-only private mapping.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> mm/memory.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/mm/memory.c b/mm/memory.c
> index fe131273217a..826353da7b23 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5159,6 +5159,14 @@ static vm_fault_t sanitize_fault_flags(struct vm_a=
rea_struct *vma,
>                 */
>                if (!is_cow_mapping(vma->vm_flags))
>                        *flags &=3D ~FAULT_FLAG_UNSHARE;
> +       } else if (*flags & FAULT_FLAG_WRITE) {
> +               /* Write faults on read-only mappings are impossible ... =
*/
> +               if (WARN_ON_ONCE(!(vma->vm_flags & VM_MAYWRITE)))
> +                       return VM_FAULT_SIGSEGV;
> +               /* ... and FOLL_FORCE only applies to COW mappings. */
> +               if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE) &&
> +                                !is_cow_mapping(vma->vm_flags)))
> +                       return VM_FAULT_SIGSEGV;

Not sure about the WARN_*(). Seems as if it might trigger in benign even if
rare scenarios, e.g., mprotect() racing with page-fault.

