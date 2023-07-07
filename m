Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAC74B717
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 21:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGGTbe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 15:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjGGT32 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 15:29:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150842685;
        Fri,  7 Jul 2023 12:29:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367JDKu0006983;
        Fri, 7 Jul 2023 19:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=oLsZ9ILFfECOMWqQv3bFBfnvXKAqw7j2kybOugiM6PU=;
 b=EnpsFpl/de6SI8W8TgiPz4HMmGYXyFG7aF7LCpTT/xTcU9bx4fQbTLgFSdCX+Dy2sn8r
 7skm+exOq0pY44ylTdvbsPGf4shFJr80bV5S0bv5W3E6xNfXQ/dGTGOSgN/i3egIOn7L
 duOLVltcirzuIlAH2677zN1skXYNmKcY1s/sKM8qoDHPUCzznK7U81oEGUikLXZrQnPY
 5EqKD4vB/tRsFA2gx+Dn0lgNds+mJSoa3l5vvC3DehNawS8cd/EqKKiBCPfWOsRydwGM
 GyhdcUHL88Agenqgp9i/D/QCcCeId5OPPeGd7rni7JiXJgZQgZucnk29rRYSnSDkaFH3 0Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpk6ugs5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 19:28:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367HWQSF013477;
        Fri, 7 Jul 2023 19:28:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8uv5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 19:28:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+I8roT7zoly8FBhxaiPpwBv5DAusHylji+jYZ9zGGYi9oEHJX/uxlMJgWjSiYzL08iaR6qOr+y0ycdsDGXzREUo2SGnH97RCeDWqgaD6EvzFaQ2GMQhlwIfzJcJDgcONL2sdJzrn+IJhgwK9FV/e4xkqJHKIiVdPJZos++CQUtOlP1DzAqibciEThaHcsnkXotbGInLmhbcenElxQ0jEgy3Ij+R+woYw0zGpxqxitCkp1N7yPioFZiFykO6mdTNZoP4/5lsDmGPfpW+8GzsYbI9PgJvlfX4jlprY3XIfIgmepjBQRmusjTbb3/TG5nP5lIrWQ7nN7QBw21vR+tOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLsZ9ILFfECOMWqQv3bFBfnvXKAqw7j2kybOugiM6PU=;
 b=Dzib4Pft0Y8EHeCS6vVuz2GWzHN4DkcizLjJ+SLazpANRldpgO9fYCxcB34bGNJZ4ahZmszdezYWGgQLj1SA1gDu5fODVB29SjqEPEWDBlShVpnvnV5YUS2HORPH7kugiFSnz9c1yMXqGhfJzv0XMtpUAu7Si/Q0wMaS51kglPm3iQtjpvnBCVPRhh0kvH+noT8mKIKsNeuoOW6HQ7Ivh7WkrUFzhBaHRPsGvDP/d+1fQnJWFG65JrqK7xQIfRGRLh3IMxTs44cRfeIDcuVCDjhRmnJESezt5uFuABAF6WZuWWZ1aTUwjfPVjfxIgpc8L+WfF84uCpZH0pBxCqOXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLsZ9ILFfECOMWqQv3bFBfnvXKAqw7j2kybOugiM6PU=;
 b=gfmb/ZvoaMJv4hgp1BZbCvQO33QXxXq8+vRI+f9qX2TdM46HxeWjg3IE0kokiSP+Xp2Pdwx3dy4n85WH9yM4xx6mtIL104cbf3AxDu4tuzaFHB1IOiz8HRn1YbAEivRZ4BedrV/0wBqnxTMjueXM5K0qHT60JD48ZCcPKdrNUXc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4267.namprd10.prod.outlook.com (2603:10b6:5:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 19:28:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 19:28:56 +0000
Date:   Fri, 7 Jul 2023 15:28:53 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 33/35] maple_tree: Update testing code for
 mas_{next,prev,walk}
Message-ID: <20230707192853.3hnl5zsozzisjh26@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
 <20230518145544.1722059-34-Liam.Howlett@oracle.com>
 <CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com>
 <c5f29a53-aae2-1d1b-9c98-5878a046d1f3@bytedance.com>
 <20230704152217.q5ovvsvwgdcshs7e@revolver>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230704152217.q5ovvsvwgdcshs7e@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:208:23b::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: a272f30d-98c3-4b35-1d5d-08db7f2067d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNaapWYy+h2IgC5dCfxwhiRRML8AGHv+ybvh9r8XFZmCI2ae9CMKCgvb7Me9pSGziCvy8jhdepvbDyv+letin2FaMT4SSo72wbgnVhvkZQvRFElbOAPYIGBnfapNseScDtwQMyKvq5U1wCjpN7givIf9aTDkiv0kz8KY3jlxL2wR1yL1EWp2/TCbkqUn/lnoKWPBaFm/5Ayjd7gMf9RYNX+EZv8rEqS/CMIHBEg5tdOxAbDaV/t9XsCXoEMd+dzbLt3z5yalhJ0QmWp//wlCKrX0sJDlPKu487vokOlcmHceMBD6ZI0zFQhfXlBWCYyACCNXK0LbSaMK1eaxj6U7qx7bW2qkez1IJ1+FO99TW8XdraygAbXMYGG0arhBDFSHZe28Hf8aEeYeVgNXMvdG9S6He/A0zOfEOXcPE7CNu1zhg39kPeS9H++E45Msc+ON35kwbnoJ7Cbr3D+US0ZshyXCthH2OMBgSQpBXPMcWkYkkA5MGtxpT75rZg5Z7Xh1P+rfxjBu6b0FdXlMnlnHiZawA1IfJDyf4wjbEXhCnz+9o6KOU/MGMPESRLL5wsjD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(66946007)(66556008)(66476007)(38100700002)(186003)(86362001)(1076003)(26005)(53546011)(6506007)(83380400001)(33716001)(6512007)(478600001)(9686003)(6666004)(6486002)(110136005)(41300700001)(5660300002)(8936002)(15650500001)(8676002)(66899021)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVVuS0JvUWFtMXRDOFc5MUZ6NE1MRmhFQmN1d0JQemVkUGtIa0JLQi9DaFZW?=
 =?utf-8?B?RGtuVnVLUWk5aG5veVlnTUhhcVV3VDdHdDFlV09rdW9xRXdWZFVmY0FQamxy?=
 =?utf-8?B?ZkVGdGYzc1ZUa2RjTGJ5WnMxK29hakJxUlpqQkdORGFLU2ZWN0M1eHhjcmtp?=
 =?utf-8?B?cWY3OUxEcjF0YXZMaVJOSU9obFpYVklDOFlTM0dDRVFGY1pmTDNLNVlTS0ZY?=
 =?utf-8?B?N3ZzbjRTZC9uZjJPb2cxVjg3ZXI5aFFVeER0SDhyR29yTy9COUswNFZQTnZ6?=
 =?utf-8?B?Zkd5RWQ1TmxONEFicERhOFlJdkU2djhLODNzVkJWUVo0R2p0Z243bEFNUExx?=
 =?utf-8?B?QWpmYko2ckYyaXVqWXg4cnZpZ0RPaVFtVDdJWFhvcGs2V1pCSGlDK1UvK3ZH?=
 =?utf-8?B?QkZ3Q045SjdaelFBTFJsOWFvZTgyWkwzdlFYL1hkNUhRc1RwSzRMNHhkYnpm?=
 =?utf-8?B?aUVQOGVaZEZzTVBmMnNBUnFOUVFNUzQxcENYWnpBdDg2MC91cnl6aGNsalVB?=
 =?utf-8?B?UVZsZm40anJuVlNWYmFtdVVUa3h2b3lVZjZlTm9MV3RDcFJrZXp5RjRwcFZ2?=
 =?utf-8?B?cUgvVi9BbnhYbGVzdWZvM1gxRWFVZThNbmlKSVRITlFTNk9HT1dhcWh3blpa?=
 =?utf-8?B?azF4UUJjRUUwRk5JYk5rNkJPNkJSby9JK1NZQ1FxK1ZsOGx1cElrczB1WDdy?=
 =?utf-8?B?K0VydTcvQThpRnEzQnNMQXVqQTI3RUt0SXVHa0FGYlN2RFBnUXp2QmtKbitL?=
 =?utf-8?B?VHg3VmVWdGZZdXg4eHI4NHVkdE1ER21LVW9sNVduTkV0RFYvQm9kM3NSYnJ3?=
 =?utf-8?B?YTdYSWdaUnlQU3M0QXBFNnN6TGIvanNzcUpPVmdleUY4MXZDTHl1REJxanZq?=
 =?utf-8?B?NXkvc2RZWFlvUWVzeCtRNjlqZmZ1Qm92d3gxTnlzM0tDcmpXWWRqd3lWV3F0?=
 =?utf-8?B?QkxvNXk5alVQaWlFY25VbFIxYzZhUkZFU3FVZnhGVFNmaDVZQlVUREUyKy9m?=
 =?utf-8?B?cGFYSGZTbnVxR1k0eVRpRktCUkhzcHVyb0JLVWF2ZVJmZExHRzNKemlTWFRB?=
 =?utf-8?B?bVBOcHluTVp5bGRPTnlFVTJIelFSM25ycStBcG42bWU2ZkFhRisxSGM1ODRt?=
 =?utf-8?B?dlQ0aTNxY2Vmem5aMkpUZUJjaTk2MDg4VnA2QTROODJBNGhDeTZMd2ZnL20x?=
 =?utf-8?B?V2JjUG1RSmxvYWI1UWFpN0lXWTNNLzA0bWtuUVlRVzVIVU5JNjFldFBmUFZJ?=
 =?utf-8?B?RnlHaVVHSTVoS01yeTZGa0hwZW40YklXTjBOV284aXhQd0JpQnRVbkl3Njgz?=
 =?utf-8?B?TEpna3BsVE5TZXZrVnprTExESTlhR09ka2xMT0ZFOGZ5QzIzSkN5UEt5MklZ?=
 =?utf-8?B?am5CcHBEYWk2SG9FcmNnNGdwcVhjZlBETHcweXNhN2ppL3lUbkJhSDVVRjls?=
 =?utf-8?B?UHVPTUZobGdBbXh5UXg5dThhVkw0Z1ZHeEF5cm1zL25lNzVUbXMxcjlCdHZD?=
 =?utf-8?B?bWoreUVSbUF2Z3FZY2VaYmJNcFZkTWhSMkxqSFBpbUdSc1ErTXlRbi9BVmh1?=
 =?utf-8?B?RllxSk9xaUgyN2hrWXc5NUNhSGdQNncvVHhsNXBsaXFtR2FZbk9GWVcxeTBk?=
 =?utf-8?B?OEdqc2tySlkwMGE2dkdJeXR5NStZb01FckdlZm9UUzUwaERZUlAwYnFYcWh0?=
 =?utf-8?B?N1ZvODdzendkNmRXZHFmWkVKOGtkQTIrTFk4ZERpbmIyL1BnUUxTY2RUcE9R?=
 =?utf-8?B?aGpXNTE0QmNScTgvK1BVL3F3NkF6bW93bFBQbjI4YVlrcUdnQ0x6Z3VoZW02?=
 =?utf-8?B?TkgzRU1VUVZNMGRzaWRidTdLVm9Db0QvZGJVd0RhM1VSMVFZeTNBa1J6NjVm?=
 =?utf-8?B?RFRqN0E5U2k2THpvb2d6OUszQnBlb0lxdyt1NFBuNlpJeUxHd1pPbGxhUXNo?=
 =?utf-8?B?dDJBMGlvRExoajMvTmVTSUVTQWZBZ1MyQ3VpT3JmUFRaTjhNcHVpQVFnbUxL?=
 =?utf-8?B?OXNtOXNETlB1bTRFVDNUMUZTTEhmQktXbUpuRWRPN3RaUkQ0VTNCdC81MnU1?=
 =?utf-8?B?dnRYK3NSVUxQQmRKTGI5ZWMzZi9TTXBvYWVvL0I2SjduWWdMNGV4U1pYQlhH?=
 =?utf-8?B?R2dNdmVhNkVWTHd1NWs1VkJWNWhKQmpPZG9aU1p6aW8vSzhSVTcxalg4R3Fz?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eU1BWlVaVHJPRkRjckdzRk80cCsvaEhiSEtGQ1BsTVQzcm53dE8vK1VxemFL?=
 =?utf-8?B?N0N0L0laRmJJZnNNVEhwVklkcGovQ2o0ZUhjWUdkZklFbklHSlJLRWszd2FC?=
 =?utf-8?B?OWhPaUwzSmtCTVRBdlloRVlPcCtsb1E1am95bHFDNVEzeGRyWW95QUtSMFdS?=
 =?utf-8?B?VEZ5Z3lGYTZycTRsVUo4YUlrN3VvR3dKZUNLVjA2bjYzOVZPWTcza3pTK01O?=
 =?utf-8?B?dlB5TUhvZk1IQlhHamVTUGlRV0UrWmc2ZjFuQ2ltT0R5RFFBcmNSZGxWeGxw?=
 =?utf-8?B?VGxmZnhtYnAvY2VoSkpSTjRNdzdFSFU3cWtTUnlHYlBoUDkwY0EyUWxIcDhw?=
 =?utf-8?B?TXJTQTY0MjBIVWloRmJxZEVjYmtwV1Y2ajJqbndRWTlWNjFCYlJkbkpkdnVi?=
 =?utf-8?B?K0RhaFhGTjUzTGh6SnRDWmd2SzQyMGx1eVhESzhWSVlMS2pxYmlIblZXTmds?=
 =?utf-8?B?blFxdjdvbDBpeTRQeGNTWVRWVGczd1IvTW1BMVVEeWkxRDh3NjcxRnhJemxs?=
 =?utf-8?B?ZTZJdGQrYXpGZ1liNDI5RWgxWjJhZkpyUDMwNWxDMFNPZkpvMm9jRzF5eFMx?=
 =?utf-8?B?SEFtTkNCWVBrMzg3T1A2V2pWUCtsbzBEdUh3VjN5SlFRT1FsYWNJZnQ2V2Zw?=
 =?utf-8?B?U3lESythSDVnOXFSRFdpb2pkN3RMd1BQN0ZTRTFJR3FsV3BXNGV3cW42WEpN?=
 =?utf-8?B?aGhqczA2STluclR3N1dpSVI1ZEJFbTNVWU9rWmNIQ1BDODZiUk9ybjhrS3c5?=
 =?utf-8?B?V2UvdnJlNi9HcjRmUFlQbGFzV3c5ZTRXdUZwRXRIaDNYaFgyWUFsb2t1Tmxv?=
 =?utf-8?B?SE1TdzJVdmVEOEZqZzlTY3NTY0tiQW9mL2VvclNhRlVTNkZ4dHJYRTBFVFM3?=
 =?utf-8?B?WFdwbDhsOWVoRmt4ZFY5VnhpY3BYajdmc3JWWXZEK0Z4RWdkdnY1RGJ6WDBs?=
 =?utf-8?B?MVJETVFCSmR4K0o5Uk1kT2FNbytrVE1pc1hDTWNYbTlkbG42OGN3bjRJN2lu?=
 =?utf-8?B?d25tUkhuUkw5VXpiTGdkbFlBUytoaWNMTVRSVUNoditFbjJBNFM1ZDhqTHNG?=
 =?utf-8?B?Z3BpRWxCOS9WV2J5bnZHYXd5Uy85cGVYK2ZXVkxCdUt6MStiV2grTXl6QitB?=
 =?utf-8?B?aWl1UVBuTm1sZW1iNHMza2tsRnkvZjRuNDJuMVI0UmJqSXBMNmw2K3gvQXo3?=
 =?utf-8?B?UXVwN1d0R0ZMZExFaytYSHlRRC9UU0VBMkpYZXRLSFFPL0k5c21OVnMyYXVX?=
 =?utf-8?B?VEZzL3hzWk9FejhVMVp5YWJYdXpSVk9QUlNiWmpFSjNPTkZldz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a272f30d-98c3-4b35-1d5d-08db7f2067d8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:28:56.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmuHga8mRiWJcIYW3HqemmWtvs6SWC3BSkhHsj1eoJhnp+O+u3f0oEg75g47RIQmCSyCZ7nGunZQg9UGu3MCQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070179
X-Proofpoint-ORIG-GUID: 1f-Pi3DIUbhkmqMyEKGfr__XSxsDgO4v
X-Proofpoint-GUID: 1f-Pi3DIUbhkmqMyEKGfr__XSxsDgO4v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230704 11:22]:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230704 11:11]:
> >=20
> >=20
> > =E5=9C=A8 2023/7/3 02:20, Geert Uytterhoeven =E5=86=99=E9=81=93:
> > > Hi Liam,
> > >=20
> > > On Thu, May 18, 2023 at 9:37=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > > Now that the functions have changed the limits, update the testing =
of
> > > > the maple tree to test these new settings.
> > > >=20
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > >=20
> > > Thanks for your patch, which is now commit eb2e817f38cafbf7
> > > ("maple_tree: update testing code for mas_{next,prev,walk}") in
> > >=20
> > > > --- a/lib/test_maple_tree.c
> > > > +++ b/lib/test_maple_tree.c
> > > > @@ -2011,7 +2011,7 @@ static noinline void __init next_prev_test(st=
ruct maple_tree *mt)
> > > >=20
> > > >          val =3D mas_next(&mas, ULONG_MAX);
> > > >          MT_BUG_ON(mt, val !=3D NULL);
> > > > -       MT_BUG_ON(mt, mas.index !=3D ULONG_MAX);
> > > > +       MT_BUG_ON(mt, mas.index !=3D 0x7d6);
> > >=20
> > > On m68k (ARAnyM):
> > >=20
> > >      TEST STARTING
> > >=20
> > >      BUG at next_prev_test:2014 (1)
> > >      Pass: 3749128 Run:3749129
> > >=20
> > > And after that it seems to hang[*].
> > >=20
> > > After adding a debug print (thus shifting all line numbers by +1):
> > >=20
> > >      next_prev_test:mas.index =3D 0x138e
> > >      BUG at next_prev_test:2015 (1)
> > >=20
> > > 0x138e =3D 5006, while the expected value is 0x7d6 =3D 2006.
> > I took a look. The return value 5006 is correct while the
> > expected value is wrong. This is a problem with the test,
> > it is not compatible with 32-bit systems.
>=20
> Thanks.  There are a number of tests which deal with larger numbers that
> do not work for the 32 bit systems.  Those tests are put within an ifdef
> to avoid running.  I guess this one will either need to be altered to be
> 32 bit safe or added to that list.

This test should work on 32 bit systems.  The problem is that the test
sets up different size trees for 32 and 64 bit systems so that there are
at least two levels in the tree.  The test that fails checks what
happens when we shift off the end of a tree - which differs depending on
the number of entries needed to create a two level tree.

I have a fix for this test, but I will hold off until I test in a VM to
see the issue below.

>=20
> > >=20
> > > I guess converting this test to the KUnit framework would make it a
> > > bit easier to investigate failures...

I disagree, I can see the above failure in userspace on 64 bit systems
by running the following in tools/testing/radix-tree:

BUILD=3D32 CC=3Dgcc make maple && LSAN_OPTIONS=3D"report_objects=3D1" ./map=
le

In fact, that tests more than the module as it will run RCU testing as
well as using direct tree accesses for another set of tests, which
revealed another test is also failing for 32 bit around allocating
nodes.  I also have a fix for this now, but again, I'll hold off sending
them out until I see the below failures.

> > >=20
> > > [*] Left the debug one running, and I got a few more:
> > >=20
> > >      BUG at check_empty_area_window:2656 (1)
> > >      Pass: 3754275 Run:3754277
> > >      BUG at check_empty_area_window:2657 (1)
> > >      Pass: 3754275 Run:3754278
> > >      BUG at check_empty_area_window:2658 (1)
> > >      Pass: 3754275 Run:3754279
> > >      BUG at check_empty_area_window:2662 (1)
> > >      Pass: 3754275 Run:3754280
> > >      BUG at check_empty_area_window:2663 (1)
> > >      Pass: 3754275 Run:3754281
> > >      maple_tree: 3804518 of 3804524 tests passed
> > >=20
> > > So the full test took more than 20 minutes...
>=20
> There are a large number of test which are probably going to take a long
> time to run.  I'm not sure what should be limited to avoid testing
> taking a long time on old systems or even what would be acceptable?
>=20

I'll look for these failures, perhaps on i386 so I can have them run at
a reasonable speed.

Thanks again for reporting this issue.  We should be more careful with
32 bit testing in future updates.

Regards,
Liam
