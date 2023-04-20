Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF16E95E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 15:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjDTNeZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 09:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjDTNeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 09:34:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4946B2;
        Thu, 20 Apr 2023 06:34:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K80Q25024590;
        Thu, 20 Apr 2023 13:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/2pU+Mjx/eBHFI+Ocgv5dApy4c7xbvi83CIcgbZ+0ug=;
 b=Enebl3pIUrCu8b3W8hhboMpTS4eo+8VdeMea3XA3rlVIofjaq78z8A2LDthlkwSPjV32
 hOjJSPrg0kmkB+M8NYC/7Q+59eLU5Z7qyY0VRpaTJdcLg6ov+zzh2TWTAINpEeEbJNi7
 63lArTbRB5QW3I+xtoib1YU0LqyeLn4nkCld14xi6VE6OVcjHhs8dCwWoUnINaMOyC3K
 CbTgXQRPL0EtePFeW91Ftjs4Q50nPJ1Ch0ujIFrDecCSuUs1eSH3xO7zN0ey3JCiAdly
 A4BbWJLM+Y6yVkYGTNWjeCGUgNbJZxOjDvF8zEA34Wi/JxTKcJ8SVNjrS1cBbmzGx1x7 GQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyktatspr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 13:34:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KCkm8D037046;
        Thu, 20 Apr 2023 13:34:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcea8vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 13:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qhf36ch6rFPCK5ofNQR35wMC5HW7YY67v5COGXzAZGY7OkIg3MLK8ZMQfuNoIEmx1r1hB4JIJn6WeulByjLKR59iNModFrBdOxIRDBmkJuyeQJUGvVHEI2xgysmv2L3+5aD8qk/IekUV/wy+BrlVaa6ENHkQXEKn6X5pZHl1RadEmXyWOx2adnG4hl6pW3b4dyneanGVxYg6MRQ63LuqhLs81XCOp5QxesfLRTppDrm9VxYL4c9FRcvmR9hKGEhyx5abKDGXTDlG2lA9HJvzw1uBHfQzIlm7ofoKtyNDXBQZQotutza1TldrNO+c9a2+wSCk9Nr+unAuQSS7b86dUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2pU+Mjx/eBHFI+Ocgv5dApy4c7xbvi83CIcgbZ+0ug=;
 b=c+E6Y7kAiDW8GNoY1uT3ojhQDZKjn8ub32HaHJcaXmCpzoYzpfw/3F+IOhpHCI2TwuA31iQqsSneWy/iuzTgzCT/W76Had1iBXLHsKX2A90CC3ZUeevEpaq6fH1eWMmvK0jWcnafP5BQnGuqyvvSoX3nEYf2EMs1S08ZcLF54O3jFoEJbXafXVuRCo/TS9xGu9ENjMzWYcyW4DR8qQFsw2ChOiZBYTv8RMjaTLGIFjwKY008aW2CkMuSHi7WEDcH52ddx+HayB6b7EirRfdOGkV3uUSh6xEieUkC8zruAxlCcsJXEntFepmwqvxykdBFQvkpayUBc/hhYgEsSx+JEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2pU+Mjx/eBHFI+Ocgv5dApy4c7xbvi83CIcgbZ+0ug=;
 b=i6Jb09P+KkNimt+aUT2SV12iFIQceMwAW8PgJIfsMUWs0pdXHqSAB6Q7nRqXPblvm/fWZH1ZpwBVTNqD4805Pfg1aW2feKaGKbppviz5LT2269wT10AfxYAG+spO9g/0fdlm/GEtwxgPQUi7XjtIh8s6j1ITwxm149q3r3sbEvY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7557.namprd10.prod.outlook.com (2603:10b6:a03:538::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 13:34:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 13:34:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Gow <davidgow@google.com>, Jakub Kicinski <kuba@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RESEND] .gitignore: Do not ignore .kunitconfig files
Thread-Topic: [PATCH RESEND] .gitignore: Do not ignore .kunitconfig files
Thread-Index: AQHZcsgLgDo41T00xkCS6kRmtJgMq68zzOuAgABnC4A=
Date:   Thu, 20 Apr 2023 13:34:09 +0000
Message-ID: <A921F514-1167-4C67-A52C-D49EDCE6F6B8@oracle.com>
References: <168191307928.6696.11689169705819224951.stgit@91.116.238.104.host.secureserver.net>
 <CABVgOSmH=SgtJy1U5tfLwYjWW32WheuzB1F+XJRzD9qtR+bseg@mail.gmail.com>
In-Reply-To: <CABVgOSmH=SgtJy1U5tfLwYjWW32WheuzB1F+XJRzD9qtR+bseg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7557:EE_
x-ms-office365-filtering-correlation-id: 0afdd4fd-1608-4939-53e1-08db41a3ebe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKII7RtU5Zb5jIdVsEIvnvx16n4v8FQ4m1eUTj5xZ/q6IG8VeAt157HrSSOoT+SWlO8Y85iudvyFbFD5miJtAWfQ1wXsxX3D8w3bYuYsvrAUOgXKzNEGAtkbcXLnOKx/IrUC6SSjjxyt+qkozqMowl5AUn+qZuaFjaGzmy4YyBq6kW5Jl/B7aPw5aq+FDjxisXSFAXtQPrLbfCBHn1Ta7NFxAORITjUvUEi2XBZrP3t06k59HBfTOGxaPrRKb4PBV0CD9j7dN+tm2Ovp6NjDgcSuVQnMRH1crYckmRhXAML6q5fLzpWbjB8mDLumU8dz9GpuaYV88M9vzmyf4bMZgl5XlDDZfKhd1Zu086cbwziLhdnac0RDiJZ1zaUuzD6KnHVh2oXVCjA/H/EQVHW2D13XPv8DrMYlJ+8ZSCeRXhuCka0YEqwH89E34BEHAC7P8xTzMi2L57Ig8N2CzoRd0MwWdkzvJfxfzUGSoXzsxYAzmbnRs6SBrzjXjdMWp/NEtz5soX5TxOlzYFDhXbQo12tdehUvcy9V+PFq573KZpnPJDEOlyy4+9V1LLvCx25xQAn1R5eO6KUYLyBXFnZuvg7GXm4mDfMbBZ7mYlwpE7srXKgClWDpEH0o4AvXSraUptCiXsTHfrvLfZSuaRBE3jpTQKm+rkUWl92hOi5WI9nQDrakMmkOF9BDF5BJIYG3DL37lFnYjmruEkJxuYgcCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(83380400001)(110136005)(86362001)(33656002)(2616005)(53546011)(6506007)(26005)(6512007)(36756003)(966005)(478600001)(6486002)(54906003)(71200400001)(4326008)(66556008)(66476007)(66946007)(41300700001)(38070700005)(316002)(76116006)(8936002)(122000001)(38100700002)(66446008)(64756008)(8676002)(91956017)(186003)(2906002)(4744005)(5660300002)(142923001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wK3IxPq9X0fvWM9Z+dBlSEt/hGWwdtFYtmdps3yRJfDZBMI780cC4uF3Jhvl?=
 =?us-ascii?Q?WNerh9QhFbQWVyco69wDzL3nu0jA+q9fRxjiK03aNXMFxp7DH8PyWxdSCSjm?=
 =?us-ascii?Q?hxxLIRLKy0jIp10NJS/PwwrqbyOpA9U53UpqRAWEMdcsbSUpRzapTCjEJ1c5?=
 =?us-ascii?Q?SmYXdPAL+9F0iVzz9HiHd3B3sJ8/M2hJnmrp2j0HGywT+W70L6YiLkfupxVs?=
 =?us-ascii?Q?TkTlgRqw/VgbZJPxtYOurzdHnqPGSevoBK2dAhA12hbcMypzEGHiZln7oWli?=
 =?us-ascii?Q?UGNZvtxxE5KT9jalsXxlxg+ZEp//WJbm4zWJz9bNhLyuEfbRVJfV9aFjwj94?=
 =?us-ascii?Q?/qUsMvTKbpYv25w7o8S7lnBcAdoWZWlVlW04RHJ7i31IqQPOrnIRZo19TwxL?=
 =?us-ascii?Q?bwLaiyETSLmOrsMb/KZ2IsHi+1rco1NO7in+D0pH7MNfKFMWxujbNg9ZDTYK?=
 =?us-ascii?Q?7SubVZv20EV0yJ66zYUmSF18kJxEeGnfpnQglsk6eaWe8JZIby8L1jE6DQyw?=
 =?us-ascii?Q?Sp0LQPCrN8GzzcGMpel9AOQ3m1CLPqEJtVTdlR0K+fXqMEaPiTooEQPrXD5g?=
 =?us-ascii?Q?uTToFyZ1m5PZspLOnV0ILfBQcAG4YYGn5+GZMQQwt/JK/xP4dazaocHaoHNq?=
 =?us-ascii?Q?jvbZ79s046qh/BQ+5sg3cH0l/GC4pqIWfW7OBcxs4y6K3AL60EqOOWggx242?=
 =?us-ascii?Q?PHIzD8K6duGa73kFh1l/DPnmUVp73b2ZNkC++UJcFj9ZCEXHeLQetCWEQo7J?=
 =?us-ascii?Q?lCIBqdeo2NVsQU6ZJQAO8lBYTok1TxlmDsO9e28t4cCPz2soL1bPzshIJspr?=
 =?us-ascii?Q?2DrRoozvvK2mq4t7YXuANr3rA695CDIyKACDd7w7bu03vem28WOQhDSGRE2r?=
 =?us-ascii?Q?uqKaD+H0HAjgXHWWjmningxThETMRfdZF28xSN1YEZmTspWVbA4bJ7plyvlw?=
 =?us-ascii?Q?RCCdgrSs3QmdTiwZqblD4i1szDQyX90x3Q3x00OFuuFWFR315Cb/n1LHxsxA?=
 =?us-ascii?Q?pT9OJaQ+qnT2AmHr2drEPe8qXZVMvboVK+C60t5HcgR6/NW1TjK/tWasLb7k?=
 =?us-ascii?Q?jQGF41hSq0J6Vb+F9bAbt0gFg0h0g44Hkn7MLD5aSOzO0N93owZlY4RajIE6?=
 =?us-ascii?Q?7MK8NkTePeGw0xqWtwMZ4D3iXxgJsEG9QT86n6FrBohB+gCfHm+bW8hiUeKe?=
 =?us-ascii?Q?EWGIT2Nsq9SWfJGLfhPWWbvzZqTyhBfnwFF7YS439arrYjgw3CnMpHF1+nw8?=
 =?us-ascii?Q?B2RCVmuvx69r1whBScnQWJwQGK2nluz4QuwjzWAJiJSnXdlFFU9kCkBII1ov?=
 =?us-ascii?Q?YTgI3ps1nhi97uAfYZkRF19eMowAjSBiSAeK0s+ukxW5OtsfE5Ypgy7bKAIL?=
 =?us-ascii?Q?4gPU00XecaAf2/xD6YgCYm1FIpJf+ghAWCLEM/McdSIdAt5qOlyYyBlA/CA0?=
 =?us-ascii?Q?cqgTswEM+TKSWUjd12B7iBNe856hOL5t5FF4czlsZV0iEEHMaGZUVagpc3Gr?=
 =?us-ascii?Q?JQCOpTPX/YABcrVWyucvAq3clDznrmjtyFW1msx9PXoIfD/Lgi/uwQg5C3EM?=
 =?us-ascii?Q?GUXbmrDj2cC0ryS7P8snhufSM0jsPgS0VC3xBkDphR7SMinlLbhuISH3sqmL?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7A90D2A90EAF04696C9420DF5199B7A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tLihX/d6AuOWHa5Zyf/suKg/xm260e/ORS9wboi5bu22GBMN2wlLlnXtwzxw04+cPAOf6DU4SUT8paTkweaMM5DcvfTpMevKQ7hTWze/1ceZDhFHh8NPhOLrcsijvUhJo/FHCctThNY2RKg/dkThYunUVRb3k/DT3fVEcySYneRpsSfYX5stDbrhBxq3TVr4MnFGPPnWsD2joEMf6Xijg1sQfzq/5kzGP6+d20KrdsN+1y93P/IkCGIQPPkt/9n0ndJ89KxSaIZbm2aI8SaGX6PINaoSWqRsMWmaC4aetAHj2Sz1Ty6nyO/cUAo+R8WUZtANFVlgBTCwgz8HxopE3tQI4XosJyz41jNQcy6p9dgd0DKvk3UBlvNSC2mgaqCFiEwN4QdI08N9iMA+GSjeOBmTccLCQWGIZy7lpIShimto+1hDZBL+FQ37E4I5MOiNCSeZwpKNH41908cPL5lXQwwspiG92O/Gby2QE9B7sNullwgQGjUh1sU9bZ4CvqJ1Dnr0YplpZLzy15vajO83IWAY7k+RkCcZYNC/rLzTXiXFyIUBv3raFNJB6JCLsxtVJl3s0LZtfwAOPLUrv2j4GdGpavUhxCmpsLFvOjrfXe20vYZvSwFGQXYyW+GpC3jwozBjmGOoBKmiGD12Cd4CglmDL1hzZ+56LbiQY8f4lF+bWjpfRNuv1IBq810HZOTWyI3Z+eM1t8RoRcinKqDOZH96fDLWDSbbtCk8GvHgzJeoF0oC1/OxhMuqmvX/lOJIpv4rcsFCKilqSun3951btSsvdV+/PwkdxGH+zIBH8Zr8KljytIZy3jFKJf7+W9aX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afdd4fd-1608-4939-53e1-08db41a3ebe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 13:34:09.5913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XEA8OrweY9KDjfdGsFNoXdtTYOWQqkIk65bHDNEgbeMuCEdHXns9eXM4Tb83p8ahlHuSYUYGM3Ljz2TjQ9prA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_08,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=799 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304200111
X-Proofpoint-ORIG-GUID: HE5Ba1b0Epr6--b1RSYG82fYVLJ8UpAk
X-Proofpoint-GUID: HE5Ba1b0Epr6--b1RSYG82fYVLJ8UpAk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Apr 20, 2023, at 3:25 AM, David Gow <davidgow@google.com> wrote:
>=20
> On Wed, 19 Apr 2023 at 22:05, Chuck Lever <cel@kernel.org> wrote:
>>=20
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Circumvent the .gitignore wildcard to avoid warnings about ignored
>> .kunitconfig files. As far as I can tell, the warnings are harmless
>> and these files are not actually ignored.
>>=20
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/oe-kbuild-all/202304142337.jc4oUrov-lkp@in=
tel.com/
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>=20
> Thanks very much.
>=20
> We have an equivalent patch already staged in the kselftest/kunit for 6.3=
:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git=
/commit/?h=3Dkunit&id=3Dcb8865fd865f5b2f656d0d91f3b0146ef1acb10d

Most excellent.

Yesterday, Jakub accepted my patch in net-next as part of
a series that also adds additional Kunit tests. My patch
can be dropped or reverted to avoid a merge conflict.


--
Chuck Lever


