Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1025544C44A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 16:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhKJPYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 10:24:45 -0500
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:16206
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231148AbhKJPYo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 10:24:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPCtVuVLPnr+oBYyW6P34IauVuvE1s4xEhNCsdyuRG8RhJwpkOtHNIjmVC7IV4GKGIrLIMkL1TmJQjQAOCnPalXX6bfG++m9iVdHXy+NW126aJHWE8/HCKUSPo+ItTEb+JVrCE7bfxhJKNVkDeSPcuwSq+NOLDV3TmtSH6qpvWekR/QhLxNeTKITO1jFNFG606w6lVI4tsGnJBeLh4/fa8ou2+aYUHFVTeLV1zCUgAfzXlXCenwrmL7Bca+g/3ISZu7VgRLpED/Yu4fm7PNoS/zi+/q8NmDTR+KQ5c+cq7gDfrEyEAKBx3qxCNr6HD5nzXkd8IYYGVlcdob5RaEkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0qRMyI8auFOGLBDH0E8gQPrF0wZc8jAySp3hMZCv30=;
 b=bHY2HnAAgVHIsxhY6oDX41hQ6+Nf1KSJjFJru0tdnsR5FwuIntFQP/52yql+TUesTbwcXl2cSDR6RsyjhQINZUjj3zZ8tcpOZqqqiW5wXQW0eidXLfrsRxIFu4ueVH/sdE3Uo4kkvUpohY1g3XR36Y0x/mnwE9svZtFWP41NpZGJfE5MWGWu+bfczPCYFFfxcoJyzQfuctHwBoZeqBP3JtvsOfVasbHeJqB/rKEutTCziD8MJYqa96HcGD3ANAN2PnsixkMZKAN3Y8OBNE5J6I8SOM2mpdmOhO7qjEF+5FV1/Gr/71w4frDwacRFJFX78cC3QfRu5lCef4INeiLaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0qRMyI8auFOGLBDH0E8gQPrF0wZc8jAySp3hMZCv30=;
 b=zqkvKrLSA6rAcm8UPfhqrGtCGGT6A5B8l5AKmWNKhDn0RWRNEWSmi/qx+X6AZFKpMe9TgneUNkDcTB8EYuoPwTJQq8llXttBPb2jngI+yKW4yEBocICbYXdmbvE1zl4P1an5Q4qO2hteOTHsnHLp5pwuxwcn9aHK/8qk6MoDqGxfYG7Bw+kPrSg7s1uzk5cLxIVZFdklRhZifBaUCvvvjt/jxKjZAlKPFqkhRLbrCjpBO6KrtT2WZiNZ6i9/Dw9LWoU2uyMitGkduEUTv2DHa0mBuKmqL/Bj9h4A0+XeBXWZmU0t/XH6lVevBSQLVKNhceGK8ZQrVtdhp6ZjQqv3Hg==
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:418::19)
 by AM9PR10MB4824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:413::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 15:21:54 +0000
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb]) by AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb%7]) with mapi id 15.20.4690.015; Wed, 10 Nov 2021
 15:21:54 +0000
From:   "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To:     =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC:     "longman@redhat.com" <longman@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "guro@fb.com" <guro@fb.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>
Subject: RE: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Thread-Topic: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Thread-Index: AQHX1iUJ+hEXYuVug0y1LdvFiDDLvqv8yVeAgAAS1aA=
Date:   Wed, 10 Nov 2021 15:21:54 +0000
Message-ID: <AM9PR10MB4869C14EAE01B87C0037BF6A89939@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211110111357.17617-1-felix.moessbauer@siemens.com>
 <20211110135653.GD20566@blackbody.suse.cz>
In-Reply-To: <20211110135653.GD20566@blackbody.suse.cz>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-11-10T15:21:52Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=e213f4a3-4e0f-4b21-92c7-8dd0b1e3037d;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a666b28-71c2-4165-6b04-08d9a45dd407
x-ms-traffictypediagnostic: AM9PR10MB4824:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs: <AM9PR10MB4824E49C86C8D8345D9ADF5B89939@AM9PR10MB4824.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSk9c4okLQz7eUQMi5Gf/hixIGZzd9H+z9mrnSYDyR3xXETLfWQsb4GtS5CZlEefiQtm72hiGng2tCjCXGtdoV1umyNflduLmEg9Eg+PWIXVYoHFfOjvR427yZtPrd3LW2WwgTFoTKry3AJv/RQGwI7k2Rx4I4WKQhqMrbLy1KBTINORHoRcCXFS48MOzO4bpF8hFfKEJZMuBQXFS32JAlK9EOcOy6xfGvA6Ae4inlnK16BhgwEiLBepEUzFYi7wYjp8OhB5N1JP6toLsGWPVSlLuS5E8w0dP3W93aSfmomWY0VJLNSOLMiNxQBr+99L6fq8iX8SBAb/ZeejJpFT7CAOd0ZrZCr+n7CMYJGSI8rXyiGz1byXe76OTIRrYhQ4wn2e4wyfRY4XV6zec747NCUSCOHD/46bLAeVh2l+BX9sQBsNlguzTERaHbT8XW/QZbHSyA58gfyC/Jb3oldBNq2U4jrYaryY89nBWCGiH2he3vv1XOYCb2OFDLTo88qRcq5HUoszzJLLTolfRmm5t66dNTECCYYmPQ2YWgFrrFvqZIqKjpBIWW6YCVpvpJjzUUWFC97enPLBdBbCYbKfVzEBKyomNpuIDZs4qZpVRdxHWLqcHu+kk2hJCAkJG6BA8pmQ31SJAy8A0G1fq909vwEIOlBKSphfVMniBPa6S0CmiMCMqK3bzOAQCdh8je5mciF5I7PCzvfXCEwgKCGKAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(107886003)(9686003)(33656002)(26005)(5660300002)(66556008)(64756008)(66446008)(8936002)(8676002)(71200400001)(66476007)(86362001)(53546011)(54906003)(76116006)(7696005)(6916009)(82960400001)(122000001)(38100700002)(52536014)(2906002)(55016002)(186003)(4326008)(7416002)(38070700005)(508600001)(66946007)(6506007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OMLGEi1vg2Ua1UiVRHP7JWEFrGITmioOymxvpL/u7RNQcObsvORFKbvzNB?=
 =?iso-8859-1?Q?vBtUQbE84+DZsNYgBZCUHuolT5dmx5Ln+oY4DhvudYAmD+Q6IC4Vze0kM9?=
 =?iso-8859-1?Q?lEpDjHzG4ERP8YRf11cM1P5IRmcGLqAGRGvj2fBEbTcJ/3o7gLnvwd40FH?=
 =?iso-8859-1?Q?/BJ4Vj2c+F0dWcr27EqZei+mvIqS50NkYC6sndRYooDfbSTl5sAioi+Ctq?=
 =?iso-8859-1?Q?FQSWkqqP69PZGRIMQr1yICWVSXatPCN8HNib3jBUcXcWM5UuzPQClb5W+c?=
 =?iso-8859-1?Q?LfntND5k89mkKcOIEAadha68MOMTF2W/+uPYv8YxllMbCxcolYH7g3FXmD?=
 =?iso-8859-1?Q?Kh//sNgC1iH0aTTPg+qg+qrMqUGTPlfwQg0KNKR1HWA+eAuCchoLv+Wrfi?=
 =?iso-8859-1?Q?1vu49MIAV+oa9Nbur2FCfH1xLPYJAfLLnNy95OGD/kBvgZgXKD2hNHTFPS?=
 =?iso-8859-1?Q?vLxPDIXYc6afAC0fyA0ly/2B4BOem4ER+Vk++Zj2rVAADWH1pWp47gmgEp?=
 =?iso-8859-1?Q?dN3B6qzsAYNJM0rB1mZQT/Q72OQ/pN7+UvUBMnPrSqmtJcFeck6+rM7MCS?=
 =?iso-8859-1?Q?srIwSDqYl/hGQ0u29tQJtfVMsA3IM7XXyyg8fKj8bjHjyb0TMtQxDpqC/U?=
 =?iso-8859-1?Q?TK2/R1VIab5Vielz7C7kBjehzWZxVoHXMIKRol0BF1A1yxzQGNGi7t3JwC?=
 =?iso-8859-1?Q?+r5C4uqeB9T0KlcLGBisfdD8lQbKi3Hav24VsH7NSbRk0R/Zd/DoTfCqjW?=
 =?iso-8859-1?Q?xqnVidSdBH5AC+tus3ngKd32p6XQ+QvVegmAYZ8Q1EkcUFeGbcnC+Pqph2?=
 =?iso-8859-1?Q?o28u7LY0pNETPUrjQzNh7vrPDiooVYFDx6EBRrE7s2zDmk8W+KZg93ZA/M?=
 =?iso-8859-1?Q?is9Tu2M7wU0pimlcUbh7MZkfJJVb84hRm/iuvOFMs6zVtL3XZ495Yo6F7f?=
 =?iso-8859-1?Q?P2deT25zbAqEfHaJEoUKUVpUUmoPtqBf1o87Hl4wRkgQDRKj2qgr8Obv9P?=
 =?iso-8859-1?Q?x6HYl7toe7iKyaI1LMnNmf51iiIOs0VP8+kHye7ooiBEZL51jFECVSWMAc?=
 =?iso-8859-1?Q?2SS4KGK0s2I6CYTNcyORJUkAYombNWwIr2tE7+hpM0Y3UDtAgs8jbFcB/R?=
 =?iso-8859-1?Q?mMA77nU+kP2FN7d75xt7iVi4TU9DARAMEvBgh6R1s2grsWj0FfPCZjODc1?=
 =?iso-8859-1?Q?vglRmF5FI/tluop6ootPtgVv2Rfq8dy5pn6dz5BfO2lJJJjDGU8Wtvx7RV?=
 =?iso-8859-1?Q?isd/krdPd08iQwmEGrHLdL54HVwOK4Z1+yzCeWb08RVaBUEdWh4iCwNCeA?=
 =?iso-8859-1?Q?hZ/ZlhhEVssLOkAtFPMc+vFGaBTkeANZ9ZF9oC2EFPtfvncCP1xLAO+WIi?=
 =?iso-8859-1?Q?pkhNk7EsrNiqLtmN7WnhfSGBF4qfUUjM6jFoqSz7WCJA7EAbl4x76N7Nhe?=
 =?iso-8859-1?Q?MELITK8EKBr5tcFrj9ASVaLlVCO6ZL3Pl5qe/RUJBvF3L8vsFtinGP7kdR?=
 =?iso-8859-1?Q?UI82QnH2NfNRu40rbyOb0LEMzr+RoiJcpgt78zpvRxzZgHWhWS79mOXU8w?=
 =?iso-8859-1?Q?l7aqHmSNms+cRjHENyDtP8yLuhHRyEVSh3BY50lAdFqbHDjdNS1CB5yb8M?=
 =?iso-8859-1?Q?45b3XrJFxPx+xVolFiJRz6A7Q9K3jMc6eDfZwaB5zLCgqKr8AgtDcRs6DT?=
 =?iso-8859-1?Q?hZ6AqDK/qakvb9BOUOO1bWYkmWHWvNOo6XFRx8+Dxuq8f7NU3KtzrHMWXT?=
 =?iso-8859-1?Q?hvyg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a666b28-71c2-4165-6b04-08d9a45dd407
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 15:21:54.4441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pT8+yiqRcL956oEMQQWdxLSJqEKGJv0jZX6PP6PWBf/MZVuuWNTD8wxy+L5uCoAwYLPaw3YRV9RNUKARMacadJxJXn5/1cTIDHZ3GaXdlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4824
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Michal Koutn=FD <mkoutny@suse.com>
> Sent: Wednesday, November 10, 2021 2:57 PM
> To: Moessbauer, Felix (T RDA IOT SES-DE) <felix.moessbauer@siemens.com>
> Cc: longman@redhat.com; akpm@linux-foundation.org;
> cgroups@vger.kernel.org; corbet@lwn.net; frederic@kernel.org; guro@fb.com=
;
> hannes@cmpxchg.org; juri.lelli@redhat.com; linux-doc@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; linux-kselftest@vger.kernel.org;
> lizefan.x@bytedance.com; mtosatti@redhat.com; pauld@redhat.com;
> peterz@infradead.org; shuah@kernel.org; tj@kernel.org; Kiszka, Jan (T RDA
> IOT) <jan.kiszka@siemens.com>; Schild, Henning (T RDA IOT SES-DE)
> <henning.schild@siemens.com>
> Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type =
&
> empty effecitve cpus
>=20
> Hello.
>=20
> On Wed, Nov 10, 2021 at 12:13:57PM +0100, Felix Moessbauer
> <felix.moessbauer@siemens.com> wrote:
> > However, I was not able to see any latency improvements when using
> > cpuset.cpus.partition=3Disolated.
>=20
> Interesting. What was the baseline against which you compared it (isolcpu=
s, no
> cpusets,...)?

For this test, I just compared both settings cpuset.cpus.partition=3Disolat=
ed|root.
There, I did not see a significant difference (but I know, RT tuning depend=
s on a ton of things).

>=20
> > The test was performed with jitterdebugger on CPUs 1-3 and the followin=
g
> cmdline:
> > rcu_nocbs=3D1-4 nohz_full=3D1-4 irqaffinity=3D0,5-6,11 intel_pstate=3Dd=
isable
> > On the other cpus, stress-ng was executed to generate load.
> > [...]
>=20
> > This requires cgroup.type=3Dthreaded on both cgroups and changes to the
> > application (threads have to be born in non-rt group and moved to rt-gr=
oup).
>=20
> But even with isolcpus the application would need to set affinity of thre=
ads to
> the selected CPUs (cf cgroup migrating). Do I miss anything?

Yes, that's true. But there are two differences (given that you use isolcpu=
s):
1. the application only has to set the affinity for rt threads.
 Threads that do not explicitly set the affinity are automatically excluded=
 from the isolated cores.
 Even common rt test applications like jitterdebugger do not pin their non-=
rt threads.
2. Threads can be started on non-rt CPUs and then bound to a specific rt CP=
U.
This binding can be specified before thread creation via pthread_create.
By that, you can make sure that at no point in time a thread has a "forbidd=
en" CPU in its affinities.

With cgroup2, you cannot guarantee the second aspect, as thread creation an=
d moving to a cgroup is not an atomic operation.
Also - please correct me if I'm wrong - you first have to create a thread b=
efore moving it into a group.
At creation time, you cannot set the final affinity mask (as you create it =
in the non-rt group and there the CPU is not in the cpuset.cpus).
Once you move the thread to the rt cgroup, it has a default mask and by tha=
t can be executed on other rt cores.

Best regards,
Felix

>=20
> Thanks,
> Michal
