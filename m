Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B1E5AFA07
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 04:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIGCmh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 22:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIGCma (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 22:42:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2055.outbound.protection.outlook.com [40.92.52.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26A86061;
        Tue,  6 Sep 2022 19:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh9HSVyt/0YcOjwFGRe+LdswhiycciOafnJpOVCUP7QJPK9WwFMQZF7qZB8gAKy/OaM8RUrbRPoevCiyTUEKuPdyiPBuM6LIz6/8uYEuOJcNmF8SDm/OvdQAlN9HxbjGFhJoj0aBU3d8ckMPhyTKYqymwDmsoZ1BgbSTexkHlkAmJ6jVDtVSTp00qjD+QXFy0IxFSTEpV9WbHE+q59fOD4Th8kwxApZVvf9LfpJhXA3LZdIJsva9k3dwxmOYrklyOh25IilrGyhapo5U8mQ3H69usM2/AP5ocSffIl9elgA/fDwycvEYdrdK+AyPkcb1n3tbAzzj3+DwhgADM/1LRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jKOSPp+XZBvAM6FoyF8CZkDR84bLqkHZrjiIlOwpig=;
 b=GPSliXBNlcsZGZ2/x82NjDViPYHEriLiLBKJ/GzslarAN4RZ5FKaPu542Yfyhrl3my/iQ/58EYgunbn1kw7VQ7Zllc5NayGJ02uZNoUqEHCMKqemgO0f/cSSyPGxIa8w/Lkmt6KlRi7DY/EUhY+TOWWHLISU+paHXYq9OaWlAMQ/kjij9TUnea9bVi1F21brIXjDWSBDailIwMOSHDxtz+xWMR5+TDXrC/miaYxAqtaBG96ift2K0kcPSAbQfTrdaJiiezLyKBANuUHpRIuFz1m7XPhYlZMw4PnpD2pxgwUoL3/LnVpEQnKvxjJey+OH3kvmpvRucZ66jt6mWCRyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jKOSPp+XZBvAM6FoyF8CZkDR84bLqkHZrjiIlOwpig=;
 b=Od5LgoGSPCLI8hahIqa53Jr+g2cwGZLX2YvsZ0zWNB6US5IS+dkZjUiFt3MI7DUKh4xdc8bV5n2ZvvkOON9YOKklyvfieyAJ5KOHTR1gUHU3+K8FV9zaCYuqqULDFt6vCqVDpco1UnI7TOg234OAfi75hFTuRm+5WmH6+Qix5IIyt3jAHlB5Im9YJ8y92QnNRXbyjcuq5fCKtNHY6fuKSELpVeaAV3bx0bDfbjAG7INRHFgfvFODUrA6TI3cbJvg2KcYHCf9qGOLB+3qD0LptsbRPuPqAxjCbVPRG/9myLVgdHgU3ns3ETLAI55iMZe09CbiSMhXy3HrQFR/MzAWeg==
Received: from PSAPR04MB4167.apcprd04.prod.outlook.com (2603:1096:301:2a::9)
 by PSBPR04MB3910.apcprd04.prod.outlook.com (2603:1096:301:6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 02:42:19 +0000
Received: from PSAPR04MB4167.apcprd04.prod.outlook.com
 ([fe80::9a5:16f2:9f1e:9bf2]) by PSAPR04MB4167.apcprd04.prod.outlook.com
 ([fe80::9a5:16f2:9f1e:9bf2%8]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 02:42:19 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH V5 15/31] x86/sgx: Support restricting of enclave page
 permissions
From:   zhubojun <bojun.zhu@outlook.com>
In-Reply-To: <8f7c676e-952b-3409-312a-be4cadaf7194@intel.com>
Date:   Wed, 7 Sep 2022 10:42:15 +0800
Cc:     bp@alien8.de, cathy.zhang@intel.com, cedric.xing@intel.com,
        dave.hansen@linux.intel.com, haitao.huang@intel.com, hpa@zytor.com,
        jarkko@kernel.org, kai.huang@intel.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org, luto@kernel.org,
        mark.shanahan@intel.com, mingo@redhat.com, seanjc@google.com,
        shuah@kernel.org, tglx@linutronix.de, vijay.dhanraj@intel.com,
        x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-ID: <PSAPR04MB4167CAD68C500068F37B3B6FE9419@PSAPR04MB4167.apcprd04.prod.outlook.com>
References: <PSAPR04MB416734EEED145D832A04B936E97B9@PSAPR04MB4167.apcprd04.prod.outlook.com>
 <8f7c676e-952b-3409-312a-be4cadaf7194@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-TMN:  [ox9HvD1XYm0D6QRGejwKEXdh6BgmY2uJ4PmBJ8WkF8Y36NGH+LM3mWqbwo6C2xlc]
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To PSAPR04MB4167.apcprd04.prod.outlook.com
 (2603:1096:301:2a::9)
X-Microsoft-Original-Message-ID: <EDFC4D34-B397-4ED5-8F43-B90BDA52F9C0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c910ef10-6fbe-4cff-58db-08da907a95a0
X-MS-TrafficTypeDiagnostic: PSBPR04MB3910:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1HoK7hWuym44XNcK6TyuteAE65yxdgiwpc5ivPWAgbuOu5ny9KGRY9rid3ZCYDYKRSsvvzNc9OPV4pwVCtoHvTDRWnRPk31OZxwclqEHqAT+jgEUIVap3cPu8I5rxM3DkOqAjsx17O+RhsnihFHpbxFoj9pXcPf/ZJpTKckIc7Hya1LnYkyAd5ToqFYiFdfwExNxljFsUNaonolLX3YOx/WrtWl1Be9KM7TXPAax2hN9rLsWheV5RDipMnsBJXUzGiI3tY6s9MIqe+FVgVlT2RvyC0YQ6QEMTABrtY+O1VqFwIeUmjaZgr2WhhYLBs/A3I/tyCfodi9tVbKp3CNu+162P5LeqDu1FkMjmp2a7ErgFNWd9wBHdq1Euf5FzpHw/9246OMHV0spA00yqtn3sK5RF3ul4LYqedHBGOBI0wf/uoIV0y0V9s0h4Ctdr3XGBTLy+bOKMvDbEZbfaqW9HAsTGIHv2w0Z/VYoyz1BCvrWE4dEqEUUJTOSNGBygvAYDkOQ6Uy6tyuTawgF0Sjc9XWJ6IIjM0uNK09Xvk5kSGC6Mp6ArkPIDsIa2h2Cg4LzwZul96Tj+M2eaA29ed72t/qm0wCA51PP2HdBzicVy8JCXrnH+uZbbOd9LH2wr/T51m+F4ydQd3CfW8xOqFuFhIpj7ZvlX3QMwOwr9uU6Fd6mY9/n11dh1acUDrcaAWp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDMxMmZPcG4vUG5yTERlVGUzQkxEakdON21hNnVsU2hkOUF6azRmbzFyTUcw?=
 =?utf-8?B?a0pMQ3Y2WGI1aElXdEVpOWFlSTN0Nk5MSGc4V2lpako4QjJLTW9yc1M5Z04r?=
 =?utf-8?B?eERRUVVWcW5BOGxKbzRHV2tlWUEveHNGSTRNTGFOalVhNXgvWVZLK0s1MTFG?=
 =?utf-8?B?S01DeElHZzFWalU5TlczRkxxYlJaQ2czQ050eTMrZkV2SkF4K3lnLzQrT2VW?=
 =?utf-8?B?aUlxdjBsMDh0cUd0bCs0T25XbGQ1b2xFN3A1dTdrWVJXeXdWcWljTFVSdDR4?=
 =?utf-8?B?TmxPcGhBbHRyTGVvQ0R5Q2p5VXJxM290Y3Q2TlRVRi9TT3pySGQzekZMSFh4?=
 =?utf-8?B?Q0dqNEttbXJrZDlYSlV3RW04czZCOUVDMm5uaGJ5dlVHelFRdm52Z1ljQ0lm?=
 =?utf-8?B?N1VMek82dVV3dmpJTDUxTlhrblNodGIxa3Zrdjd2VyswaE9JQUFqdHFkdlhK?=
 =?utf-8?B?TnAyTUR0RXRaT2l2dU1JZVNrR3kzbTlTaHZ5RFMwaGJ4VGhpWWp5QnhtMFJI?=
 =?utf-8?B?K2JCVC83L095ZmtBdm16Y1hpODZKR1VDcDhPbUx6Ny8xYkFMR3NNUGtidFhh?=
 =?utf-8?B?TnVGTlBTQlJxb3MwQVl4S1pHL01SRitRcjhrTnErQXdVZTdBZnJWVzVPQ3Zy?=
 =?utf-8?B?QTZ4QnZpaW1EajBRdjFrZXBUTEIvRzBTRjZCMWpJUkczL21odTZNV21pZVg0?=
 =?utf-8?B?THBwZ0RWV1BWZDJHdDdGNWNZamdZcVNObmNuYUZYSVQyQkNqemFld2ZoQmFF?=
 =?utf-8?B?SEgvVEd1QUhEODJST01memFMbTRUVWxLeFp1akhBYng3VXBDUEV0UUJHS2lX?=
 =?utf-8?B?cFREbHF5Z2Nnb2g4dFBLUTVXQVh4U2syWE1xYzlNeThzbElLQmx2bHBzWHhC?=
 =?utf-8?B?YysyZWZhcldhREw2N1hzbkI5VCtjVEhobHlib1ZXRlpRaEE4S3dIa1oydlBk?=
 =?utf-8?B?dUZvcjRYSXhtS3AwbmFKblUxemNSMGZjMmdNcW82eFBjNXExNzE0a2E1RHh5?=
 =?utf-8?B?dzlLSnZiUmpzSG9rTGZCOXhHeGcrdGRMSHlkQTg3a0NlSjJzR0NhL1hjS1BD?=
 =?utf-8?B?dTFMMTRUaSsxYXh5RWRGdDgwYWE5TVpMMmozV05MZVVYSzZrVS9sTFd2UFBF?=
 =?utf-8?B?eWlJS2ppZzd4cHFZUEtJbTg5QTRrUjhkMDhhQ1d3NTRPTHBLTkJybFRDT0RF?=
 =?utf-8?B?a05JR1djcloxWEVFSHNwZHcvYVhKMlVLeHlOdWlWb2xBcTFQb09UODlpaXM4?=
 =?utf-8?B?OE5Wemgzd3ZWVURXZitlemRjWVNTVk02VTlUaUNsMnloQlFWUHIzRkp1Z0w2?=
 =?utf-8?B?eUtSQ2pId0NHTWJKa21CUXdHU1dVekc3TTR5dGI4WkN3T0ljNUM3Tlpzcmd0?=
 =?utf-8?B?VjI5eHh0ZTl6dnNsRFJJTUZJVVZSbkxyanNmVjF4VmdFQ0VkOVkzYWJFeHE2?=
 =?utf-8?B?OWxWYm5ZbjlNL3FFQytSTXJ2K2h0dGVxeVoza0cyNXZjWXlvMDE5UjFCZnkr?=
 =?utf-8?B?Z3hxeEkza0kyUTRXYlprdzYzUlNmV1RyU3pyNGJLc256emtLRG1DL0F2U25N?=
 =?utf-8?B?emwxdEFoS2o1UStteC8yVWhQWmxLenQvWk9QTUZtL2dFQTJ6VFJqbjVTaWZG?=
 =?utf-8?B?THVZSVJtdEFKQXdVckdsUWFHTzBOTnc5WVlqM0VDVnIwbTVNNFFadVVHQm9v?=
 =?utf-8?B?WFdsMzRsTytpcC84WEUxdFl0NTFkOTZ4TmtPNHhaRGRGTi92WUxkN0tlOFQw?=
 =?utf-8?B?NHVKRGc0VmRNZVdYeElaSVhuSlZ0Ukw2MHFKQlczOWtwWEtQR1JhMzl0bTFo?=
 =?utf-8?B?YXNGeXpFNEVsQnZ0algxQT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c910ef10-6fbe-4cff-58db-08da907a95a0
X-MS-Exchange-CrossTenant-AuthSource: PSAPR04MB4167.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 02:42:19.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR04MB3910
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Reinette. Sorry for late reply! Appreciate for you detailed explanation=
!

> On Sep 2, 2022, at 23:22, Reinette Chatre <reinette.chatre@intel.com> wro=
te:
>=20
> How important is the performance of page permission restriction? How
> about the performance of page type modification?

Enclave applications may need to change its page permissions at runtime.
If they change page permissions frequently, it may introduce substantial
overhead, compared to applications running on native Linux.
(`mprotect()` is more lightweight compared to restricting and extending
page permissions inside enclave)=20

But I have not profiled the detailed of the page permission restriction=E2=
=80=99s
performance. So I=E2=80=99m not sure how much benefit we will gain for perf=
ormance
if we move the ETRACK flow outside the `for loop`.

> From the hardware perspective, a single ETRACK can be run after
> EMODPR is run on a range of pages.
>=20
> Some things to keep in mind when considering making this change:
>=20
> Note that the enclave's mutex is obtained and released every time
> an enclave page is modified. This is needed to (a) avoid softlockups
> when modifying a large range of pages and (b) give the reclaimer
> opportunity make space to load pages that will be modified.
>=20
> Moving the ETRACK flow out of the for loop implies that the mutex would
> be released between the time the page is modified and ETRACK flow is run
> (with enclave mutex held). It is thus possible for other changes
> to be made or attempted on a page between the time it is modified
> and the ETRACK flow. The possible interactions between different
> page modifications (both initiated from user space and the OS via
> the reclaimer) need to be studied if it is considered to split
> this flow in two parts.
>=20
> With the ETRACK flow done while the enclave page being modified is
> loaded there is a guarantee that the SECS page is loaded also. When
> the ETRACK flow is isolated there needs to be changes to ensure
> that the SECS page is loaded.

Thanks for pointing out such case which I have not considered yet!

> It needs to be considered how errors will be communicated to user
> space and how possible inconsistent state could affect user space. In
> support of partial success the ioctl() returns a count indicating
> how many pages were successfully modified. With the configuration
> and ETRACK done per page and their failures handled, the meaning
> of this count is clear. This needs to be considered because it is
> not possible for the kernel to undo an EMODPR. So if all (or some of) the=
=20
> EMODPRs succeed but the final ETRACK fails for some reason then
> the successful EMODPR cannot be undone yet all will be considered
> failed? How should this be reported to user space? Variations may be ok
> since EMODPR can be repeated from what I can tell but I envision scenario=
s
> where some pages in a range may have their permissions restricted
> (and thus have EPCM.PR set) but which pages have this state is not
> clear to user space. I don't know what would be acceptable here.
> Looking at the EACCEPT flow in the SDM it does not seem as though
> EPCM.PR is one of the EPC page settings that are verified.
>=20
> Reinette

I agree with you. It is hard to handle when there the final ETRACK fails
but EMODPR succeeds.

Thanks for showing the case I have not considered but
needs thinking deeply!

BR,
Bojun


