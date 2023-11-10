Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB91C7E75AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 01:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbjKJAJf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 19:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbjKJAJG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 19:09:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBACD080;
        Thu,  9 Nov 2023 16:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699574666; x=1731110666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FR0tbJ0iU6tfkUvj50xq0SCUlduho+4aB7oLemWsfgE=;
  b=lGzZdQ+P3p7gA4b9g/SgZdDFHbLHYzHWeV2Me662vHwqbQRs3X/WXgta
   pzlOcM0eoGAGQi3XKgndqc9h1Oq82+V5jMvMZ79SnFaS58gY28Jrs5D4H
   LNdqiBSNRi2sDe3P3+XjSSm7YLGBfTXcrW/KaeeJKESBFeZKOS/56ajnj
   iHiGsrsNKYtXKFg/Xe31/AVVQOvgOlzw6jiYLsj8H34qRLpjs4KdbLdZo
   leMIDDRMiy/AnM1J94OeeqdcBQ5DhRVAKZ0Py8fQGuaJH7CVeX2vy9B0a
   qrsmZy5kCBE43sSW8vmYFRydYy+j3QFgOtN/V76Z/OiLfQtGFiWowBWc/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11648168"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="11648168"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 16:04:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="880785391"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="880785391"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 16:04:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 16:04:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 16:04:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 16:04:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8O+0s0NquiTOiNdmsoA1ZYXptaAmVqILNzx3BeoEj9aSuOeNJ3DJ7RCzR+YIU7N2kKONb+DlvOolilF6m3KakA8jESXdbKsSruTdH97HkjGmX5av+wKO4JFkK1xrkblZ/y+WufRbYmZuUbVw86SIzmPq/D7EUHSmsx0PjLk8GRAupQKH87DrbomRDkCJRi33ouNFxqmw88vgYe/lptNNvlPkje57UQST9sMXQPYg9o32ESSe6dP0XjVes+jxZUZ3/hsJRcWBK5jzy6kwBvKKt1+zHD0DIGh0YPmvQ2nPecUiRU4/kkzGNp80xC4vi7xuaafqEQVBpZrAehdsTsWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZDML9hfpm2BehO/o+FvMTFXDbJGIG3q0kiW+9f8P7g=;
 b=X4HrpvUgCKh8gSBE9wXIVOYWelTFDKt7HkJ8h20+eN4+szPzIzP3SHUDtWQDdKl9YITvwiCMy7C9dXZKEv2Ua2Q++RDYJlWRnFEE5tekjhWrpr23HKotTftLApYCIdvXqk9hUxsYaxKrg2r9BMld625tTrCdZa3v9E/Z+U18+yvNYGuUYeyt0rtm5VKvyuDvFbk39Ew1Jqz2kBMJBcJPtLCrU8yviRiSkN2oqqz5oEysV9C3mmi020FkG0105izuHRk2ySaDM44mhEX63+++xGM8aovStP/XB+1e6/KqTkoaeFwReOXcaQZWdLWisYSM9Ujisg6OFPI4ByajobDRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SN7PR11MB8263.namprd11.prod.outlook.com (2603:10b6:806:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 00:04:17 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%6]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 00:04:16 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        "Gao, Chao" <chao.gao@intel.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit controls
 in vmcs_config
Thread-Topic: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit
 controls in vmcs_config
Thread-Index: AQHaEnXtUpNORx09eEG1bKB7uAQ1LrBxr3WAgABqx4CAAJBi0A==
Date:   Fri, 10 Nov 2023 00:04:16 +0000
Message-ID: <SA1PR11MB6734B37AB5DDCD14A41A6ABBA8AEA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-6-xin3.li@intel.com> <ZUyeATu4Fd2xI0+h@chao-email>
 <ZUz3cPmnqSq7Lol9@google.com>
In-Reply-To: <ZUz3cPmnqSq7Lol9@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SN7PR11MB8263:EE_
x-ms-office365-filtering-correlation-id: ad6702ad-fa9c-4f7f-1e18-08dbe180942d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fy3qLhULMMcCn+5JRKYiV0nHNYXM+EoqX1yMCsH9lNHWfQBTGEsCwxaL45k6emtvt6BPKB8MXQgl25Q3kuALQ/fbCq5ePD31lpyy7DDd/9YNXxa1giDU4A6yc9/Fnjz3fSos0ANSXBlNeIvkOF9Scr9QB7+Z2rVWQEiaLjOVlucSGi2//hKOdyi1JgiOZqyjAFVlmumcAIEQSATq92+bKnNOdYChZFd8zX+CC31t14pGrxtFYhcev5oQQodjJ0AVUxdZdEjKj9G0N2ykd4lfc5LE1AXR/19RQhY/0mbzR6JqQMrBWmFJwdFSLcnFyur4AF5HOJxDf2+UYp0eyBXKIUY2juxSZ0Yt1sR70GEWVb2PTkrN+IIwEjXs0cUINp5EBQJV1MPynpqTMmvi+SpKkQAbwl3jYWkVgmsewtud5ZwVRu93n98HaBRjgJ4db8Z6NlkBn07nalSqQR6YS/GsM0Smg/PO9dpahudITy3YjjHk3xYsnPZo4bDPNkjwP7V/Xmbhy4xly2Rl7JkiwtweZhUV3Ve/VbePJksmSh8I5J8zVrnpF2qk5473eXMRuIEX/9jflVBQhhfh8eN3zgeSR/gahWK5dbsajtQzzgGWxRz7ZH46Q8Vcf6Vcl//mPlyxkfpkD+64y5NOknA+RNeGW6TzM+c0DGIkUq8bUbp59DE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(64100799003)(1800799009)(82960400001)(122000001)(38070700009)(83380400001)(66946007)(26005)(76116006)(7696005)(478600001)(71200400001)(6506007)(110136005)(66899024)(66556008)(9686003)(2906002)(55016003)(4326008)(8676002)(316002)(8936002)(41300700001)(5660300002)(38100700002)(52536014)(7416002)(86362001)(6636002)(54906003)(66446008)(66476007)(33656002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UqE2BfqatkxqBINkCipEmQqP4IBqumBtja0nfcwdgcqo8+JNChVP3D9z4+Hx?=
 =?us-ascii?Q?1phdxaRRtk/UTg58rZ3K6/9F0POFM3Kt9OpIrFz1sqpxrAeSq4vZeigcZnog?=
 =?us-ascii?Q?VDwGXwPLmBzs+UsgOLgwxVrwljuj5Mmd/DZbL2nOJYSY/pIr51ShLuMNl0P9?=
 =?us-ascii?Q?Rx6pIuU4PS9gPMOWYh5933wUSv0p2amJpM2LInqGy7esddk18RjbbRiirNj/?=
 =?us-ascii?Q?OAmSdrf0UGWyUrmLWxKkERVmejURGIW3Q2bG4uObAXa80afiierfYzg5C6jU?=
 =?us-ascii?Q?J+SC6SY+Ape8EBrR+JtBTbwcTxMntOPnRkfn76gCt62Gr8ZJ7gkp8fewkVxj?=
 =?us-ascii?Q?YdGIWQ17xM1pVAGeG3lJg+GRuadvF5JhqbDriDIAZVtUYdm990oAJHdDaFUp?=
 =?us-ascii?Q?JGoihftUvBdJDEzFo52GVy7iig776+/i1iZqMt5mxEBhZLZvH0DtAzq1IXNx?=
 =?us-ascii?Q?d1vGduzVYEadTSmVV2F28a6u2WPzw3h5fmYFNwg2Sk/rL53zBBKb5lGtmGqk?=
 =?us-ascii?Q?ewewdXARPx3hoaFegV+Z//vDZlGJ+rSjQjq+Y3G1IAGGRh0fL43/O672hlWI?=
 =?us-ascii?Q?8oOK/gVNx0bX5eYcMATna7MpndsDd/rdORsvaWiRsabdiRyiY9ckS8toOD6b?=
 =?us-ascii?Q?nnvy6BzGa7/nRpl/y/9VN9LnppvGbqQP+6xS7K7hZ4hkz7bdWLCqcKbM1k12?=
 =?us-ascii?Q?JO5qfi6vgvBEL3PMKA8DE/yi2W0h7btsW5mV5d0rhV+tegVASw3K50gJWfNP?=
 =?us-ascii?Q?T1MGfQ9tJobsm1YSubPTldCsCt3CtCxlEHF0Nq2O1V+5aWX4gvDjqhICfadP?=
 =?us-ascii?Q?ba89HSCAGBxfv5UAnPHH53gKU0YadrVBRQSfjHhc+nA8ENhdfZ3GBcZAAlJc?=
 =?us-ascii?Q?5MCdQFoZ/mrLKIWx56UfSj6bIIKH/4lYuO3FQzpscHQXa59nb2Q4sgiMLGz0?=
 =?us-ascii?Q?hXR+w8EBytbPg7MBZTGaE4uwl2tN2bztVIkkMbbGE9EaPxvUYEHLbX2EXgM8?=
 =?us-ascii?Q?DHxma9e0GAD2SlpGJGZAmOPfW+MCsT8tp6QC0rf4ZsKYfDDxF9FXIKfPdZyd?=
 =?us-ascii?Q?mBEzB4kcmwktevcUitApl//t/CVmqT8cBtaPfBK9CmCkBIJI13Icr1mMxmnX?=
 =?us-ascii?Q?BXqOvl8u4lCCI3uXWDQqKtHwDVTvVnfdGTI1oEaMQ/7V8EKFz5zJw1w2wDPh?=
 =?us-ascii?Q?Zu2bukEpWGFbfJMwyJYUxzPT918fhVgZgR2RbVDWi2khOFmK2ofHC9u7i6QT?=
 =?us-ascii?Q?BghIIU9nqN4eabQt4mZOmI4/yI2JQTM5LjAsjMRXtPWcXV88XBofoCC05nTZ?=
 =?us-ascii?Q?s0UkQ+bJxd+XWFnTPnvsMsAOmbZMetYz2jJWVPaItz0LK5wg5jeSV4Fq0X5a?=
 =?us-ascii?Q?Kw9KGww2FpAw7lMSCn1GNu+kp6MV/OV39SwO319SjZiZkWTcxQXYj6z/HxED?=
 =?us-ascii?Q?wlcydEf0mKLdXWlfZ2b6Ym2Va7eI4mEKZ5c2YHSHCLQsYKVmEGy/OuoJjjpX?=
 =?us-ascii?Q?qKWYgXhGyOP2whN1TnwjqK0NccMhI92XItqedlhgXgDBCM14OY3nqrjhlSKP?=
 =?us-ascii?Q?8BCLxu3pLpURWi1Tmls=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6702ad-fa9c-4f7f-1e18-08dbe180942d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 00:04:16.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAhsnyl79U9q5f0DWAqr6Bn4GUzQyeKFA+RY6d7UFuZRO7MocCZLV08g9zuamKv1c1OsfPA/MIwgRnlXHGkZgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8263
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> > >+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> > >+	    !(_vmentry_control & VM_ENTRY_LOAD_IA32_FRED)) {
> > >+		pr_warn_once("FRED enabled but no VMX VM-Entry
> LOAD_IA32_FRED control: %x\n",
> > >+			     _vmentry_control);
> >
> > Can we just hide FRED from guests like what KVM does for other
> > features which have similar dependencies? see vmx_set_cpu_caps().
>=20
> Both of these warnings should simply be dropped.  The
> error_on_inconsistent_vmcs_config stuff is for inconsistencies within the=
 allowed
> VMCS fields.  Having a feature that is supported in bare metal but not vi=
rtualized
> is perfectly legal, if uncommon.

I deliberately keep it, at least for now, because these checks are helpful
during the development of nVMX FRED.  It will be helpful for other VMMs
being developed/tested on KVM.

> What *is* needed is for KVM to refuse to virtualize FRED if the entry/exi=
t controls
> aren't consistent.  E.g. if at least one control is present, and at least=
 one
> control is missing.   I.e. KVM needs a version of vmcs_entry_exit_pairs t=
hat can
> deal with SECONDAY_VM_EXIT controls.

I agree there are better ways.  But maybe after or before VMX FRED.

>  I'll circle back to this when I give the
> series a proper review, which is going to be 3+ weeks.

The traffic in KVM mailing list is surprisingly high recently.  So that is
totally expected.
