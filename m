Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93C479876
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 04:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhLRDai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 22:30:38 -0500
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com ([104.47.57.171]:6169
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232023AbhLRDae (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 22:30:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md1XszgAGTQCxZZN2HLU4pHSWil8B+s4Tf4hgwimgnilOx8zAn2mqRF+pKilTuRCIasDUgvJXpnNYoB0DtzFUbm+lS2JnPp2mGnNcDLsYZumQuiT2Gfx9Gk4UqIUJh6x5qHQOaksToYF4Z0MeXzPVpMlKBqMQv0JheMfHafKL2+IgRBNG0l9p4QC6RjKEFNILT0IcUlsRJEz3vdwKIVsxUpXYD06ulltXYi62lzNg3pf6X0DIx8vWJV6oxJXJi1F+B5Wg4ZiFfBZGVeCcqjqIXVEnOv7FQFgH7VBq6V6DUPOAw0En8EPTZF/f+QJTd2YK8MOFpu+F5tPCGRZxVOEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/GTrYCVYy1QgFpqcPWfe3NN7cxht++PVfHxFeF+4Bk=;
 b=ToULN07I9H2t1a/JMR9GGIOdaqLgXM4YT7kb66bAWYHZbw8tM0KOpOTD/4xFf+rFw5beDm9jupkhy0URvQaw0WSClEm0Q+o8hzqUcv+q3YtfSL9xH8th899rAQMvWJOZbkR2F+8c5dtJeR3Vn6XGLl2EvD+PfnWi3UCplSMPmfY8B2PNV6UlRQ5KDoktUjBCAPBvUPwf3JDCueLuneDNmiebaz03zZMYGoPyY4TeBorNNx/VOYhY1vIXd9VR/MvHRf5IWJNhYRCq0jNW0v0ZmR3urq15MmXxR7AEvLUeDuwdehsigD9T9CoTJboF/8NrjVAmI5Z04w9SIWcVgXDDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/GTrYCVYy1QgFpqcPWfe3NN7cxht++PVfHxFeF+4Bk=;
 b=lj33iOQSmB8r7FdvV0loLRwMABBX43Bhjg9yqJn5WQe3UZObCoiIeOa+fg/a7WEWjU315VCAEcr2JUfrYjF9Ol4VDwE+LomwUXESVtuP0iSX663jp/eXoPzp+FsAA483gOKRKhqkcbj6vcXu/igjFoo3y7PDejQscJ6i2s8NPEc=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB4133.namprd05.prod.outlook.com (2603:10b6:a02:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8; Sat, 18 Dec
 2021 03:30:29 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.009; Sat, 18 Dec 2021
 03:30:29 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Thread-Topic: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Thread-Index: AQHX8zoAtPq2ZaVmhkCLrf0rndre56w3C3aAgAAFCICAAA9rAIAABT2AgAAC5YCAAAgCAIAATa2AgAAT84CAAAcTAA==
Date:   Sat, 18 Dec 2021 03:30:29 +0000
Message-ID: <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <20211218030509.GA1432915@nvidia.com>
In-Reply-To: <20211218030509.GA1432915@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8fd4bff-05d1-49c5-0013-08d9c1d6bd8c
x-ms-traffictypediagnostic: BYAPR05MB4133:EE_
x-microsoft-antispam-prvs: <BYAPR05MB4133702D6F231971D923506BD0799@BYAPR05MB4133.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j59G5gpULfdJkozNJ2xWMUGxSSZyazcRitlJVgMZoI2Nd3UDl6hLeNlGUPDhN2wg9O4kg4S6HTAg8X07NcFu0ajIlSuig4kf/pDPR4Dayzft5rPb249fH66Uz8tgT0nVfDtFgxcBYdKi5z1tnkwMoC2Df7CasaFY5MDgo/e/tse2a5P/pW8eQH/mRVn4kMM6evk6N+MchtmnOiiI7BRcwt0uPddgF8dl+ugPwpmb/HdTsFuKwpFtFbAEL8zR2e6ZdxbRHer1DsSqpMgM7J5VluMCKUuMutrH+IA9d+i3+EZ1FuAjWAxSin6Fdu6k1eeQO4WWAkXgP0OakRa0E2/zkzqoTkr8UgCKQZ+GX0+USroPbIb+UbmtcEVhilhWe5Tmoh750blPERQzRnK4RcwmBpTjt0Xd5AHi23yAYpjcnulC/D21GZHosQDBdXaOisTUu/Fd4LPn2kkw2ucWtZcn/mgJ6Vu3Us8a+bgzha0KYvGEEwz+sm5fQF5mB8bwwxAwqZ4OGRmqDf7BhoJ88UdFOmrHlim/cvrRxcbeRo3M/xZlBPt/9ekalCgJKENyCMOyEznKMHKzX3ZA+Mkk5DsYJYAj3mhk9m0/e2QiA4Y7g4KF6fC/ujAB9HSiXZW9Tba4UNNE6lz0KOmMM7AuDSuHQhRVSf3mYwlx1OxJdnjVhg/nY4/ZUzP9U7yG8yhajClS8GE2n6u7gridaf4AbZz+4NHqHF/nKJ8bgI1CikiTTcAlthJzCKclEXRKnHTf7ri3d8yOdiLt8KxJvmjMas4TvrLx0VdiMlAt5YaGivGsq7U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(99936003)(186003)(316002)(6916009)(76116006)(508600001)(66946007)(2616005)(86362001)(122000001)(5660300002)(26005)(54906003)(71200400001)(38100700002)(4326008)(2906002)(6486002)(6506007)(53546011)(36756003)(8676002)(66446008)(8936002)(7416002)(33656002)(66556008)(64756008)(38070700005)(6512007)(66476007)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek94aEo5SmdpY0c5TVNoWkI4Y3pmVi84Qi9hN014aVM3KzBFZG9LekE4QzUv?=
 =?utf-8?B?dThnM1JSRWFkdUc2YU5xaEt3Z0RHdTYraTlsaE1lcGlZWXU3M3U3TVFVU3lM?=
 =?utf-8?B?a2Z0T2ljNVkyZXIxSlA3cEh6UE9tNERhYU9pWVpIUEpnNUtaYkk5T0ZnMVFX?=
 =?utf-8?B?eUNvVjQ1ZnhqMXYwcUJoTFhmaENPT25KQS9GaFZHMWNOT21PYTgwZkk3MzVK?=
 =?utf-8?B?MnE3QkNyYXBBSkVJbXJKbXVLNUR3K2c1bzBZZlVRZURITEZ5SWRiTFBGNm55?=
 =?utf-8?B?Nm1yU2tMaG01cU9EdWVrK1Z1dEtpeXpvemxTUkVwai9yWmJFaE1CRExzQ2Uv?=
 =?utf-8?B?RHRvcitYZWJydjBtZys4bTZiUTBuNi93QkNORkdiZU16RDVOb04zZENZSmtz?=
 =?utf-8?B?bHFSOGFyQllnUjIvdXZESk40ajZYbXZrMEE0c2ZESlUyR1BYSG9EQnZLSG9w?=
 =?utf-8?B?VmhGSmhnaHlvV09taUV4cW1CbnFYNGtMSm8rekJKbFVRcURDd1R4VEtJOGVC?=
 =?utf-8?B?UnpHTksxbWVEdGFaWHVOcjNJTStlWmJwWW0venVKK1gvRTdOc2J3MXIyNjhV?=
 =?utf-8?B?YVhUa1h6VldtZ0YwdHhXbEFvWjdUTEt3cXR2cXR0dEJtZThRMEZ0dExWckg0?=
 =?utf-8?B?WEt3OXYxT050RW5IL0NOYUVhTTJUNjlDaDZYUmQxbmw0ODJsemk3TXlIcGZQ?=
 =?utf-8?B?TmQ5aXJVZ0kvTGlvWGtNZ3R4Tk5GYnVkaXNLQkZQV05CNm1GK0dPWmdTUUxN?=
 =?utf-8?B?QXFwL3hsdUxPWHY0RzF0R2ppZ21TWUlqZTE2VDQ3cEZGQkNXNGxmbjRFMm96?=
 =?utf-8?B?emJGL1M0MjdFaSs3MFpiU3JtTlI3VFIwL3Z6NFhISjBxUVM0QTBwa1FTeUhl?=
 =?utf-8?B?VzJHdmdmK01Qc1lVcUcxQi9VcUx1ZFJ3Njd1WkNMOTVndWg3NzB0SGR0TWVa?=
 =?utf-8?B?S3d1ejlKOW9vVmtwM25yRzN4ZG84ei9Lc3dhUjR0UXZDdC9IZ3RLU3B4clBP?=
 =?utf-8?B?b2hURWdGZ29rTUMrMm4rbTBxdG9CeG9hWlNpRk9OMjhEMG9VaWdwS2VMcTZz?=
 =?utf-8?B?UzB6Yy9Ma1dkWkNDN1BFRlY1MGZKc2NwR01XWDlpaGZQdys3b3ZoYWpiY3Jn?=
 =?utf-8?B?b1lpeUs0dEtKdjd6dk1mQWpucTN3NWs5bjVKem9xVU1mYTZSOXQ1cytHRHBX?=
 =?utf-8?B?Mzc5UitEVnZ1YjBGWUY3Z1RTN0VBY2pLK0Q0SlgzaTA0WEFrSTNLQjVBbjBN?=
 =?utf-8?B?VW5sQytuRG1VRzF5T292djNSd1E4QjF2a01vS05EaVNLT0xKY1lJOFpZdHhL?=
 =?utf-8?B?NDlnL2ZHQUE4S3VnNzFLWUJ5ZWppWnlOV2hhdjRWdCtFOVEyOCtXK3ZIbmNo?=
 =?utf-8?B?TDErU0NhaEUwMUxMVlMzM1ovMTF3N0lpVjBYcGJKaWdPbldSbWVScnRickV6?=
 =?utf-8?B?R1N0OE1EaktUQVdiOFpiOXBIUExQa1YwZk1TVWNURUdhZ1ZlTVA3Vm5sY1Bn?=
 =?utf-8?B?RmYvdDFXQ29DY3pJM2dGcU5JYVNOa3hjbXFsRjJvZG4wM2JtM2Z3WXgzUko5?=
 =?utf-8?B?STgxc2RtaldCYmFvSEFabnk3MDNvcHkvMU9hZ3RuNit4M1pDMHlRTkZQcXhr?=
 =?utf-8?B?VHI3bEI5TGpJY2VtSU83emxibkFudDc0bFlsWG9LZVJWM3o0WWxBUkdJdmxl?=
 =?utf-8?B?bjRzOWlzNTBUSkZ4MDN5NktsSUIyOWpvdmU2bDVFeTB5dmNyNzk2eTdzbzd4?=
 =?utf-8?B?K00yMmdXK0hidmpoWkVMRis5RU9CQnM2K0JwbnBvVnIrVkpyS1JEeWsvbU5v?=
 =?utf-8?B?TFIwSGRjYWVMYi96MmlEQWpmQ09saUdPSnJZZlhXaXd2VExOYWw2amQwZEF1?=
 =?utf-8?B?b2xLZkk0TGU0d0h2VFFpc0RPL3dKZnJrRE9xN1hmdFFsbDkwdkFNdG1ua05r?=
 =?utf-8?B?cG1oOVMwTXR4aWNBeDZYek41YnhqMHN1RnIwRVVkdVF6dSt3ZWtLbysyMnRX?=
 =?utf-8?B?QmV6cGRjazVtZXovaG43QUozcDRBK2R2dkFKKzJlV2Z6bEZQdUpiOFRUY1k3?=
 =?utf-8?B?WUx1bVRVMW5QTUVmV1VPbllqUzR6QlBQU2txdnZYc0tqTXJUTTVsREh3aGJO?=
 =?utf-8?B?UGFLa3JzeGhRU1dSR2RmNitLWkFiRGovODRkTDRyc1Rla3JFUmtHcGtuVjV0?=
 =?utf-8?Q?hZ93R8ftQKWAHDs9HBYfTTc=3D?=
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2725CAFF-EE92-4F26-B6C1-6732D72A53B2";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fd4bff-05d1-49c5-0013-08d9c1d6bd8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 03:30:29.5304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Boimelb6bFjCLWc24duz7kAE+PesFhhYhjeKl9CcKSXuxb3tuujD7WSF0APpITTzwMJ3+glZKG4G717XQc+7Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4133
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--Apple-Mail=_2725CAFF-EE92-4F26-B6C1-6732D72A53B2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Dec 17, 2021, at 7:05 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Fri, Dec 17, 2021 at 05:53:45PM -0800, Linus Torvalds wrote:
>=20
>> But honestly, at least for the second case, if somebody does a GUP,
>> and then starts playing mprotect games on the same virtual memory =
area
>> that they did a GUP on, and are surprised when they get another COW
>> fault that breaks their own connection with a page they did a GUP on
>> earlier, that's their own fault.
>=20
> I've been told there are real workloads that do this.
>=20
> Something like qemu will use GUP with VFIO to insert PCI devices into
> the guest and GUP with RDMA to do fast network copy of VM memory
> during VM migration.
>=20
> qemu also uses the WP games to implement dirty tracking of VM memory
> during migration (and more? I'm not sure). It expects that during all
> of this nothing will COW the pages, as the two kinds of DMA must
> always go to the pages mapped to KVM.
>=20
> The big trouble here is this all worked before, so it is a userspace
> visible regression.

In such a case, I do think it makes sense to fail uffd-wp (when
page_count() > 1), and in a prototype I am working on I do something
like that. Otherwise, if the page is written and you use uffd for
dirty tracking, what do you actually achieve?

You can return EAGAIN (which is documented and actually returned
while =E2=80=9Cmmap_changing=E2=80=9D) in such case. This would not =
break userspace,
but indeed still likely to cause a performance regression.


--Apple-Mail=_2725CAFF-EE92-4F26-B6C1-6732D72A53B2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmG9VdQACgkQHaAqSaba
D1rFFw//YpZaSvjcprRy00WpYCqlXiGnvC/kpcK9oR94vZaxKo8Tf9kYmf7abyB/
f+xKpDB+8ZSI2cvNeFUhcV+I1mhePwOc/12CalFY3c/1lZi+eZpGuPmBIbhzw02p
kt9/c8d9xi1Qu9pbnrspOhBA2k1fXFvnnI7qZOWDcottCpZtyueVey918EiV8E9F
3hnquUqX8gTT7XKngtaBirzW5JPYLOM3rsOON40bGx5cYdIFm3F2oKlH3leXHvTz
UQEvebh/fspKrIM4owMbT7AiffY7SiZpPO1kk0cJxuTCKpPWgRvIO7pE7nOph9ig
1OBB/S348loTUbw4bovdnP9QjEAzwIgNC27Japbas0pyxfdzDzb4jk2dKbMcR+wP
LRPUx0u1klXZB0ie8mgod4b+wBdzMosn2LZyD83zdA+cvqRHIfZpH4iOEQiK4h1/
8H8kNZaKy+a8PzFli/W5DuG0DjK/OBGtDn3dC/oaTaannXuSWdHB8B0MbAXZlW3T
InOEyCjjJ1zABR1Ihik8zknYsbRmS5q4gCHeGJ6nh0bJcLmBlS2RyKcJixThRNMt
uk4FWCFXF4N1WeI39v4EnrVVmMzKKhRTiY3+EhV1BH7Zn6yMqh2WlvWVMxVXwx1t
iLTh2oKXPKyums1J/+PZb/PkUyvi3K0yUX5Bi0hRk7QDJMDoF8E=
=lp+1
-----END PGP SIGNATURE-----

--Apple-Mail=_2725CAFF-EE92-4F26-B6C1-6732D72A53B2--
