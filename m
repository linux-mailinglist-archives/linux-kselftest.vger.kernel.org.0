Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08D261FEE3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 20:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiKGTuO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 14:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiKGTuN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 14:50:13 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A221D0DE;
        Mon,  7 Nov 2022 11:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVoibnH0Pqnp5UTFVEDVCbhkVW2oTFPtd0RrNrOVDv/YeL5QF2IrZ2tTpbDX4RkgkTY3eiqTcRIbgNEq/FxME5HlDPjKqJYST4PDGXGZHknNI09QA+LkcEVJVJ8e1UqSFhJMN6LuJwPAh0oy6uk1VPq1p2ZgSUaTH2nosG9OlwtF12iE2rjhPJ9Etj/VCAZO4KIaicKdzNKSjk3lsXUb3kyzMYo49whWHcWn+ZPmK/RQI7kjXP/K8ArYxulQuBFo/jMrrsenS8++9B5j9p7rF91DHT1dUGofheAhB/F02vmTlN4KrZdK7L9MENsHjmeNviRVEFkBLLhaTex8iI8WAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnNg2Il4RO9/ce79b2Zrey4obWiapbVIMkkdKBeuinA=;
 b=HpqGAVsYgcSKlFLKKJzKj585aX4/QVB0GyDwpD2pHFWpz0onvJ0JGCPPX5mYlzO4EkrYN2EQyzcK5KwKckGS29TghdseFVqak4VpG90SPRkvVNfqLkp00CqB1/I8IH9LcAVNG2tyh8DLLtwkcVN0njnRTWIQI+znJPhcGSQgjpS4LHZk4mnB0cVP0tD0rdoKJtfP8YSv91cORg7XPrYhpB9p1jrKbGnxu3IZNZZEIICwX/u1FH87pBqR/fLhV4e2fF7Dc5RVf2MEMIGQTEq9dypHQfuhww3iMTTPqvisx+0Poa0clNTeytBMPbapgfVqTfqKMDOH05bSrsAamll5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnNg2Il4RO9/ce79b2Zrey4obWiapbVIMkkdKBeuinA=;
 b=KIucidNVirnKmQTz4cSVvz8zCvq0iNKh+RXJZbSpx/gChVfjT3N3NAbTcL9AYkkmr971OxgtFZpAkbS9amXvYRTdGEtqdMVzlgx+0JJYADxeGD7iUVPCT5fh8XXdNRnEoZd4brBXxzrRxNhpxRyGNzcqxH2ZqeRYkvUDhNlIG2g=
Received: from SA1PR05MB8534.namprd05.prod.outlook.com (2603:10b6:806:1dd::19)
 by BYAPR05MB6344.namprd05.prod.outlook.com (2603:10b6:a03:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.17; Mon, 7 Nov
 2022 19:50:06 +0000
Received: from SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::ca89:ffc2:7e20:16fd]) by SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::ca89:ffc2:7e20:16fd%5]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 19:50:06 +0000
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
Thread-Index: AQHY8sSPsuqGQZcSwkqSjFQS9Nwjx64z0cqAgAAGhgCAAAZqgA==
Date:   Mon, 7 Nov 2022 19:50:05 +0000
Message-ID: <6589BFC5-9DF4-4757-9B32-483294E03CAE@vmware.com>
References: <20221107161740.144456-1-david@redhat.com>
 <20221107161740.144456-6-david@redhat.com>
 <E1E8C21A-EAEB-4FA3-A9B9-1DFF81FCDA70@vmware.com>
 <c58fe356-62b5-bdec-92a7-6153a27e19b7@redhat.com>
In-Reply-To: <c58fe356-62b5-bdec-92a7-6153a27e19b7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR05MB8534:EE_|BYAPR05MB6344:EE_
x-ms-office365-filtering-correlation-id: 18076b9a-bab2-4f3c-c81d-08dac0f944da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k94A2HZItKMXowC3irT5iUB2n/5eN59MnO2Dz72cm5eM1IAl+Rr5MDxyqqMDccLV42c7yshOWjmJ0SJ0YJ0LtzG9iGGNzHRpihXQj10+ZkjHNf2I4JOq8H7AHFvO7xhRFGeafkxjgM9T5q0hSWYo6zhq5q9OzGcfowbf40KaEF1g9FWmcOu7x05WLugeyF8WQr7tax0xOhZRHOgCATTHOdRCSGt06ij/y+AuXffyyzdcFM8AdRjajD0Tw4aRPCVRqFL/qrC0NmZSTFhw3VSmNdqlzLyMuBrjA4yezzUs1Blhgs+4rW3rKJOsKCp0kWstMOu+zy+1sh1MnnXcXlwevMED0YoSQNvqSzYsB2QL/pE30TAmI41DGxhY68u5GNuljYT718d60PB0te2IOzrwTzjTbubeeQNMSdYH81+OtkxDrU9wUWmsyyx/9UhukXl6FxcE/zdATdpdqydC2XNou2YoVRl/zaiv6Ea7zb7TxdDeqqFsQihUHBkLUBeToT7n0XRBOvTjQ3OGVQr071h6isn7FXtILG5cazKsezfbD8BI+CNplGn0mxXDo5rrS4+IolaH1uZ8Iftwwr0uGecInZmu+yQlNmM4Wm8BZsNW+r6P1t9GYOq86Y87Jw8wKqrwBKtTFXo1GqqEH1JCaVJYRIrUsj5xliMwH2xB3/j++tzj4lVnrInoxNQsziHYRnXqhU24cpXEygjGQgO5CwATw491dTwHWv7bUYZeWtHTFhAS4Qlvk/9SQaDznpeEODb77wp8TpSesPxL7zJKCNARWTcTz3CinTUZVhA99vwfe0FhytvUvZiDZxl2gQMnQoOxU5C+Xtpje23YIfc6KPT9A7bmYCL4+JeymmplmS7RTXw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8534.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(186003)(2906002)(66476007)(66556008)(33656002)(38070700005)(64756008)(8936002)(66446008)(71200400001)(4326008)(6916009)(478600001)(26005)(76116006)(41300700001)(54906003)(5660300002)(7416002)(316002)(83380400001)(2616005)(53546011)(6506007)(38100700002)(91956017)(8676002)(6486002)(6512007)(122000001)(86362001)(66946007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dsy9Su5N5SFQEkY27QaUmJWDTKzFrM0EsRgxovSoXA5J529RgpiI/Fk/06Ku?=
 =?us-ascii?Q?CAJoT3NrWebEFelOB1/stts/pYe8uv0D+A/QHKo5hzS+Zj2Vq0uRVDnmDEtx?=
 =?us-ascii?Q?5falIcGCJRd39Aoi9Stub/JBWgUYD9ra8Bm8wbRnMKEOe0kSmjVlAPa5AFxv?=
 =?us-ascii?Q?lSvtRgilWlE9rN0x1HidynXfsHWY/76AC6CQ2pF/662cONfwXoNnRQMrh+lp?=
 =?us-ascii?Q?FRbnoEpY2DmQ6YRB9MgIt5mrpT+yLH25bo7cwrjrZk1AgGNvGwURNGOHESba?=
 =?us-ascii?Q?pWZZUtMqApORFP+sg6oxRmUbPM3KX3ng2gPeVwAQR5Amf+vYDFaksQlpfPKT?=
 =?us-ascii?Q?apr7W7cwGuKwUZe8iL8GwjsjeTgS6KOFjYbIkST8uyAXm8T7f7rPJNakK4Sv?=
 =?us-ascii?Q?iOTLCiO7kGku0li7/rSiqLdU9C5YH1gE1RPtscPB8LFS2iuH4ExTnAN4zS3K?=
 =?us-ascii?Q?E4HHNBQRhxXjLGbSvwE23rEB+17iVUu2ZHttVHHkimzCbEBkdkExuVmRYvbH?=
 =?us-ascii?Q?Waa99s4r6GAtpPCOhdEYT60LEFEJ8Ca5ukDOhBdeHaxLPPKV7Gu05WrbeeeL?=
 =?us-ascii?Q?TNzncRT+2SEdaJoWmcBV3eipm6yU7cYVXigxAdiSREgZNvhJwe2WpM5t1jJ1?=
 =?us-ascii?Q?gt17Bsi1Fm4Gu7hj8T4AYTkbYM1K/MA4B0zhKG9yU4kk8nDo0osFQ82hmWQQ?=
 =?us-ascii?Q?M8kzSeDoqETqzZ3e299PFva3geV0pwYJXHx6xJrmS9lyUK7x86PxYn/l6Lcd?=
 =?us-ascii?Q?erMBlGr7QfLyTNXbrAdLrIluIjzhbh+vvN6eYEprU/aBOlIjy5YFVUldQAmQ?=
 =?us-ascii?Q?aNbKPn5WN1KFeyJ0pNT1519oFy1EkF2iMMm1vqfZvXnuYlzgnYkvvt9RCK+f?=
 =?us-ascii?Q?TQKnIV5ofcyuKRYfDbJroil+zKU9glwjLrtUWAJ9FWud1AB+xqOTDkPVAOLH?=
 =?us-ascii?Q?dSPK3vG/v+6vl2g3rjWF0g97uZU7uFG59TFpAexS3yF3c2EplRLSX1hBmR/M?=
 =?us-ascii?Q?jecqsBtT80IvL8Z1ctbDuzrzc0V+vvwKXjGDZK1HWL2kiUpvD9UmZOom+SSV?=
 =?us-ascii?Q?3cgkxN2HMyAZC+Mq3oTw3jE93c4Y+q2sPBZg3WmMt7hv4mXFthanoZ9WRxe+?=
 =?us-ascii?Q?Wq0p9yQzS8kJYu4o+9vShqTE1tCVA5pontwnoNIlgkPQWZP6vxMgzUclmEgw?=
 =?us-ascii?Q?9nQff2TdkJT2IbWhK6wxh9h4OyUN5CoUjBraWq4rZbq8wolj/e1DETSADx6g?=
 =?us-ascii?Q?a/kwREcpdqIMGA+wAvKBHVEz8kbUNeJtzYZmh1sEyYBpcWmE+Dc4ieBf/Hbu?=
 =?us-ascii?Q?8YMyjd6WmxgI4SCtiRHlqcFXJdjLWfifH2Zva30WzzU2HZI5OPGA/5VKWiEd?=
 =?us-ascii?Q?txsjYrBo0IhzXx4qr5IQ03STnJZaQ9d3WoiOIOuOUwN7gem7LWRVsgwIuNqH?=
 =?us-ascii?Q?xYwFcZ1ejtL6gELtigx+HiA8NT/ORUSObPv7gYZh4cmJ4M2nU5UqkAS+umqh?=
 =?us-ascii?Q?jSeSPX00PRPdButahjjG5l1PiRBzay4l6HSpa4TB0f3/PlG7C2dvI5Twu5q8?=
 =?us-ascii?Q?HHNBj9XwSWElSqSUrLrtdnrknImO2taodl/fusQt?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4F787E81DF28345BCCAE10419209411@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8534.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18076b9a-bab2-4f3c-c81d-08dac0f944da
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 19:50:06.0143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lk2vhXp5y0Z8RPR/TrGVeOBXqG1eDKYFmzz3bgnXI8PlzaTBUi4eX8ivEHk9j1pGgXrWZGpl2grMQERyifZgpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6344
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Nov 7, 2022, at 11:27 AM, David Hildenbrand <david@redhat.com> wrote:

> !! External Email
>=20
> On 07.11.22 20:03, Nadav Amit wrote:
>> On Nov 7, 2022, at 8:17 AM, David Hildenbrand <david@redhat.com> wrote:
>>=20
>>> !! External Email
>>>=20
>>> Let's catch abuse of FAULT_FLAG_WRITE early, such that we don't have to
>>> care in all other handlers and might get "surprises" if we forget to do
>>> so.
>>>=20
>>> Write faults without VM_MAYWRITE don't make any sense, and our
>>> maybe_mkwrite() logic could have hidden such abuse for now.
>>>=20
>>> Write faults without VM_WRITE on something that is not a COW mapping is
>>> similarly broken, and e.g., do_wp_page() could end up placing an
>>> anonymous page into a shared mapping, which would be bad.
>>>=20
>>> This is a preparation for reliable R/O long-term pinning of pages in
>>> private mappings, whereby we want to make sure that we will never break
>>> COW in a read-only private mapping.
>>>=20
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>> mm/memory.c | 8 ++++++++
>>> 1 file changed, 8 insertions(+)
>>>=20
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index fe131273217a..826353da7b23 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -5159,6 +5159,14 @@ static vm_fault_t sanitize_fault_flags(struct vm=
_area_struct *vma,
>>>                 */
>>>                if (!is_cow_mapping(vma->vm_flags))
>>>                        *flags &=3D ~FAULT_FLAG_UNSHARE;
>>> +       } else if (*flags & FAULT_FLAG_WRITE) {
>>> +               /* Write faults on read-only mappings are impossible ..=
. */
>>> +               if (WARN_ON_ONCE(!(vma->vm_flags & VM_MAYWRITE)))
>>> +                       return VM_FAULT_SIGSEGV;
>>> +               /* ... and FOLL_FORCE only applies to COW mappings. */
>>> +               if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE) &&
>>> +                                !is_cow_mapping(vma->vm_flags)))
>>> +                       return VM_FAULT_SIGSEGV;
>>=20
>> Not sure about the WARN_*(). Seems as if it might trigger in benign even=
 if
>> rare scenarios, e.g., mprotect() racing with page-fault.
>=20
> We most certainly would want to catch any such broken/racy cases. There
> are no benign cases I could possibly think of.
>=20
> Page faults need the mmap lock in read. mprotect() / VMA changes need
> the mmap lock in write. Whoever calls handle_mm_fault() is supposed to
> properly check VMA permissions.

My bad. I now see it. Thanks for explaining.

