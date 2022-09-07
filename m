Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97135AFA0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 04:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIGCmY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 22:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIGCmT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 22:42:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2031.outbound.protection.outlook.com [40.92.53.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8571C79ED7;
        Tue,  6 Sep 2022 19:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+Dt4Vd3hjuGA3LS9L8YhgVpWdDefo1en5iJwLim9ytRE6m6ZJAlNLfI+VlHUPIlsgIQdH84EJkeTMt0w9bKvrjMVNXChCa8C3y80sgbz/K9QIe+rFRAbFXNMTzPU97lKPffXXPACmOA/aEHE1uKAjRh/M0kUV5i/c8Nn0W9oTt7wtt1iq1/apyUvplVJi+Ol77avAOfCCmdCM3OuSJxlJqCRjittWdNe17wDT/DkKrx+n6J7nwPHW6i+YU13E5STjsMGZmhUVf+vVhRd4O5STA736Op2/0BO99+HhTgFqUWqOool4RZGx9GtdF6XKcKVRxr23iy2wn14smj2K8Ktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jKOSPp+XZBvAM6FoyF8CZkDR84bLqkHZrjiIlOwpig=;
 b=YAfs+X0kyHUlm0JruGyknTzK1ArQlU9QKwV6zzSwk6cRMli5Xu7Xug36q2GCf0yIhQYomkjZ2b8PfcqP3fBHqvOF6LG4u/sXk3/YxD/nsv3fpo0klT1v6/dDy6TJc3UG1Z6aNhVpiWdiJVJ5OO/Ta92jsQ0m18eGNkX8PYPMpNfpZNnShjwCbSRYR2bIhX+4oAwdyX5A1TGWyXJNt+Gh05zZ+FfaFb9ztWnhOwCbIMScS6tK0dQgNQtEzxOreXI8sc/M9D6KpK9YCSbhUC1lErhtTYqaE6Ol5Y8n0NuhU7opBZQZuoaH9FMSoiHbG5cuJLjifkDXkDBBj2LYQIchKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jKOSPp+XZBvAM6FoyF8CZkDR84bLqkHZrjiIlOwpig=;
 b=HYKpp2V5AxeJylwMeFuWEpJLpEY5RUozANF/369WaQ/Lnuy7Vf/YJm6N1xVakoCdk39Hbl5u+2nBL7Q831C5JALCetKuyvq7dG5qn7VD+g0BvSJFjWD9dUssSHUbp9lGyvqB435NOB9/3Cjtc3AZxwn8DO4Pv104fA+zDipTNKb1EtrzsmHzXhUJMm/WQ7btWMT8bBn30U/YrAniIoKAND1/uHeRkgaZqf5UedjXJJ2uBEUqCUv/JJ5I4CPzv5Ec0CCYCv3ktgLfgByc1npqFjcVTsk/Rx+UEfc/Rb7aE6lYVjI7+zSupsUQfXE3xbHqIGrb/F104VFEo7/UP6ok2g==
Received: from PSAPR04MB4167.apcprd04.prod.outlook.com (2603:1096:301:2a::9)
 by PSBPR04MB3910.apcprd04.prod.outlook.com (2603:1096:301:6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 02:42:12 +0000
Received: from PSAPR04MB4167.apcprd04.prod.outlook.com
 ([fe80::9a5:16f2:9f1e:9bf2]) by PSAPR04MB4167.apcprd04.prod.outlook.com
 ([fe80::9a5:16f2:9f1e:9bf2%8]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 02:42:12 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH V5 15/31] x86/sgx: Support restricting of enclave page
 permissions
From:   zhubojun <bojun.zhu@outlook.com>
In-Reply-To: <8f7c676e-952b-3409-312a-be4cadaf7194@intel.com>
Date:   Wed, 7 Sep 2022 10:39:28 +0800
Cc:     bp@alien8.de, cathy.zhang@intel.com, cedric.xing@intel.com,
        dave.hansen@linux.intel.com, haitao.huang@intel.com, hpa@zytor.com,
        jarkko@kernel.org, kai.huang@intel.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org, luto@kernel.org,
        mark.shanahan@intel.com, mingo@redhat.com, seanjc@google.com,
        shuah@kernel.org, tglx@linutronix.de, vijay.dhanraj@intel.com,
        x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-ID: <PSAPR04MB4167F203DD60585D538155C0E9419@PSAPR04MB4167.apcprd04.prod.outlook.com>
References: <PSAPR04MB416734EEED145D832A04B936E97B9@PSAPR04MB4167.apcprd04.prod.outlook.com>
 <8f7c676e-952b-3409-312a-be4cadaf7194@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-TMN:  [bXJDC7s9FpusgvpaUPJUynE1e4lNsaSwYMdX0jYeT3g6TLkbH1pO93RP27Zq5DBa]
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To PSAPR04MB4167.apcprd04.prod.outlook.com
 (2603:1096:301:2a::9)
X-Microsoft-Original-Message-ID: <601E8470-6B60-498E-B308-B87A222AD347@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 698c356e-39a0-4e83-1dd5-08da907a90fb
X-MS-TrafficTypeDiagnostic: PSBPR04MB3910:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rk2XjIgBdtwhKqMybQ5tke3f4si74b1r//3QUwCDtLSSOttV989jhjTyxnCuTVWzcxpmnVfq4YrsVIJ+m2SoScPt0lfI7YwfGDt3LofFfPp2p+qNVrka5ouzvSOoFXou2W5g/DCmT4c2J+q/3m2g4FE+4ci3JWr0TCQ9v3q/BOqWhfbSdMMn/AHWYBtH9xolRGvF1OI3urRvv6AtofsESevfg5OVJqF9bSN1FCc9t/a4lm08uazYXMuLREqOeREnn2SE9iYftBDaSV1mFxm3/cn262bclCJ6R97bhk1eA089wB6CELOiBN8LZM3WTZnqX8SxPfGcAXesjiIWcHk5//ln3+3Iz7OwPttsFL1kPjaAaEAPQD5IS+qj5XTpS76u5+/XVjjHzq2YauhygHc/ysukavyYnruwdbDb8lEowqHQ5Es+QvwEAS7HtSpVhVGCh8h/W1LBekRgQg0aMb972YkUm0tllw58d9dj5ge2TLT1IJVAyxpZQLtuRJb2wjYNR+fNbd4AN0lFmp54TbKqOwF34nlrRynVL5z7ua7Hd24DyskDfmu803fJcr/3YBpBXpT7tiPQ7ul6BnngHnDoJ1ME+iBO9TvHVNTnAwI5zB/6mV+8EbJz7EY6H7rNCkT2KGRgFG0pZ/1HWuOgCJ1OKGPyN+eC39+6TnsSUZ01DPI4N0Ie41DVZn94FcjdIBIq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzR4S29WR21wY3FrTG9Ec3Y4R0c2TzJLOFpoVWkySHA3clZzbFh2bGF4SFdj?=
 =?utf-8?B?dXpmT0x2T3lweElZd3BjWVU0cVBwSjN4ZnVmZ3Yrai9BR09TSDM3UU1SdmVM?=
 =?utf-8?B?VDBLTm9uTDZLRE51bkhOT1B4ek5BZDBUWFIyb2ZqOE1kQlZqN2ZuUHBoUHVj?=
 =?utf-8?B?UTgwdFhXb1FZZ1dLTm1Lc1pYeWszWlFvWE9MbFFOWTVCMVJ0a09qTnlFS2V2?=
 =?utf-8?B?U3hEaURpSGRoRWxlUnd4dDM0UjVTY09XbVlIaERxTjljTUl5a0F3bmE2TlFN?=
 =?utf-8?B?TTAzc3d3OC9JWGJrekpkL3JqaFFUSGJYWUtpQXlzbGJMc2d1TlF0RENhOFZo?=
 =?utf-8?B?ZEZ5d2ROdHh1eFlHalptbVJoOENIOEFlc0l5c3R6SjQ5eit5UzZ2OVhmVzB1?=
 =?utf-8?B?ZTVOV2lWRlFUNm4vVHVYL3MvUE00enp4cC9ZUnNIOGF0OWQyTmpRN2xsWnp2?=
 =?utf-8?B?czZrbCtWdDZyVEdxbnZlbzExYmQ1bnZRb01YWEhnV1hXMlZXRnF2a05jYzBS?=
 =?utf-8?B?cGZKaVN4NWEvOXlmb2NZNUFmK0ltVjFLZTM3VmhFVnBjeDRvNDJDTFZpMnZC?=
 =?utf-8?B?YWkrUmRkcE1pbW1iR3Z6N3ZhSWNZbDNBYVVjUzl6RXNDUlpoU1hTL2VtUXJR?=
 =?utf-8?B?eVNwWHd1M3QrOVRoNmFsTEZSeU14MGk5UnZFWXdxaXJOL0FMQVlzK3ZMaTBO?=
 =?utf-8?B?aWV1cVdZK01uaXpQSGxsWW56eDZEU3BYckFOR1BpekNEZHJFSm1iQ0ltaDhX?=
 =?utf-8?B?ZkltMit0WmZxR1BrcUNTVmw4emFuay9yNHlndFVQcTFicTBpMkd2MFovbGhw?=
 =?utf-8?B?LzU4Z1FSVFM3R0FqY0xjVWE5Rms1dzY3NEJOaDJlVERVSDViNjVoY2s0RUtp?=
 =?utf-8?B?RE56d1FNUWtRZVhwRFB2dno3RlJRY3pWUjNJZlNwYUtNeTNPaWpxdmtZRWVO?=
 =?utf-8?B?amZ2RVd6Tit6eFpsaC9wdkFMT3lwWlU0R2xXYzY3b1YzNDJJaG5wWG40UXRz?=
 =?utf-8?B?TkgreGFPMWZOQU1vV3R0U21yZFlta2ZEbHptcWdTMzhsejB4a3Q4UWdLKzRE?=
 =?utf-8?B?ZmFndXJ1aFBCbW1IMnJ4azE3cWpldmdQVnU3L05ndlc3bUlwVG92S2VMRlFQ?=
 =?utf-8?B?Nk5uZzdoOUxjL2FQa0pBVzB6bnpLVEZFM3g2UXgzNWdqT1FuYnNuU2tSRjNP?=
 =?utf-8?B?U3A0OFUzbHJod1JJODVLb3huVUt0MFNMcFNaQ1NQQ3NBdWdJejIvc05EVFJH?=
 =?utf-8?B?YitWMWNuZE5WelpicEsySE1oZGkwdklrdmxwVkdad2duZkhWUlhzaEhEeW95?=
 =?utf-8?B?UTlDT0RUT3hOZThXeHZROVRDc2JkenRhRmxqdXJRY3ZxOXE3YUgzMjBLOUtp?=
 =?utf-8?B?VGU0WVY3ZGhRc0ZqOFRZN1Q3QmN1Z0FVYVBTcHBxRXhKQXBMaXVXTjdmUkdJ?=
 =?utf-8?B?d2g0RDNzWmlROWhjN0JlNGZxTXpLdStaWkhaeXpNVHZPdjZ6K2lpaWF3OE4y?=
 =?utf-8?B?STMzYXp1WjMrQ2ljTEVvelZLdmRLak5HOGJSUnQ3bjNtODJ5ZTkvVzJTUjAw?=
 =?utf-8?B?cHZZemJpY3VCVUtNY3pxWFM5ODNBYzhHQ2lveWExMzFMZDZ0djlQamF1T0JV?=
 =?utf-8?B?Nkd1N1gvb3hZdGpMOVU0QTZCNUJlcGZPNUR6eGp6d2tIY0ttekx2cGxhUVVX?=
 =?utf-8?B?SWhxVktTVDZ4WUxxdW02ZDl0YTBrZmpiNmJPOWtubExXeTA2NEZhSno2a0Mx?=
 =?utf-8?B?SEh3YjVINHRZTTdLVFFvZkhXT0V1ZFRrc1NucmJUNkJRY05PZnpTYm11SS8r?=
 =?utf-8?B?eXlVd1RCUlVEUEZJczVuQT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698c356e-39a0-4e83-1dd5-08da907a90fb
X-MS-Exchange-CrossTenant-AuthSource: PSAPR04MB4167.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 02:42:12.1007
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


