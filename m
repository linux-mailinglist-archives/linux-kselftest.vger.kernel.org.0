Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50997408B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 04:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjF1Cw0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 22:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF1CwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 22:52:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C31BD9;
        Tue, 27 Jun 2023 19:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687920744; x=1719456744;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KibszQRbrYgfuKsNIs9wAKjOgcp6sMu/I2Jnj7vuyZg=;
  b=fXVctCQktrPoHfQY5D88Kd6u/hjLXx6wjXKxXfhliuL3MrvVOD+foP4G
   dD03xHHja+y9Q6vD176DCigI4rKAac002Wkl3CQlnXu4VegAjY+wDmniu
   TEuiqHqyCKa3S0LKa5wtjYGRoVmrKw9CO3A5SMzOaviggnMH5hWEkxf8q
   xMQaxtJZ5FvxoVSvn6bG7RhWrA2PMdpG9L4AlC+/d0LwTn4683eaUDx3+
   G8gcwXFLa7H4URdN+vBB3pyvSPs9ziauubCzAudWdAUBtSvcSMSESkJtL
   PpjNkvjnPEkP59H2F1JXk7TWGup11f4hZrqW9jKTqpQ0Pz9ICY/AC8O5C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="341318339"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="341318339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="666927708"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="666927708"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2023 19:52:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:52:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:52:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 19:52:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1YNifcJUeLyqo8cn5Qz/grTeZflAblUmBSORdz8I8VkHcYOiCNxhzUK2kbkWq6O296UqPSIsP7mwgOAQW4JmY0ZBOozSiSURv3HGCTnaqTlzD0BW/nE8q0Gm2ttqj6m6T2CIlqT/3U+vsP6d385OUp6X0v9TH8aFOXsoMPxkL7KJtQBw5TD+LLAtdrbtKnBqPD2NZUy5wyFY7ZsU312G9/U1DWmJeBZFaO2AIQ0iVtusfD5TSF8M1QbHWOK8pctDRlOA9OhbSV52dMgLZIvIEWeiVPilkX8NovWV+omrs1rO/iOzLzIUrvZzTuUmt1oZZQLLYx6WoKrwBFzHkB0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBSIFQ2yfFuwbgbBoSsg063HiaKKWTws577Du3hZQhQ=;
 b=O0n9u9MoVA93aEncPfdNi/SUHxizVyalOVZi63+aB5MhGGyB4iAoBVCJLTeFZtFEIMxeA9fHppv6Hb2BuEzqZpnhmNz8Dd3gjYq5ZR7OzU3G7KLBarZ6te4PlJCCxMmeUwaUic8a58tmKhcxbqzssnHvlIq+rr/XhgX4OrTm08v+9PTmr5UhMvAjccTOp5Xa8znylZanl8RRcw17LWHaL3YFe//fYCWgdEnS4nYukA2WnZxaHTpTjdFkLLm2umtq9DUR9Ivz8XXpCIoOzkD4Lwsd/I6nnQ4uX/uu0Shc4XisYeFpjL+rAc8cdpInRb6KeLRnQOE/Gh/+im5wKc3cwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6809.namprd11.prod.outlook.com (2603:10b6:303:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 02:52:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Wed, 28 Jun 2023
 02:52:13 +0000
Date:   Tue, 27 Jun 2023 19:52:09 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Wander Lairson Costa" <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Chong Cai" <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <dhowells@redhat.com>, <brijesh.singh@amd.com>,
        <atishp@rivosinc.com>, <gregkh@linuxfoundation.org>,
        <linux-coco@lists.linux.dev>, <joey.gouly@arm.com>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <649ba059a086_11e68529458@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
 <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
 <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
 <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0259.namprd04.prod.outlook.com
 (2603:10b6:303:88::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0307e7-3de7-47ae-df42-08db7782acb6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2del+EZUjDk5Y9eFnZyOm3hNf858th3x+5TzuQbt3q/GbwicbmzACL/JDJF3sFw24CDbJqO3YAM8OWHB3eq5+1t0JTSRX8A0feTlm74o7yGpuAC4hK2vtAapqoEbJ/19HxYQ3NQQD08/4FsW6prndJdsddy/7BUVz9laF4Db6uPZaAjsVAw4LqRF953T9asTkAcGFSoj7y0sft9wWr/CyKbkjJ0xNBFQRvtQyrg46vL+wFUOU4fqNvbnjrPwlVvhsXMMXFwsXJVaKUFlOjahXSEdlO8twaA0pdkiLnWH4OzGhDMWiGlUKj97mXjZhWX5d5zJTbna6EbU+82vSrP9QOy85+TCadgXa6YTebw+Dt885gEvcwLZCIVsQloCvZ+KuccnI90viEB++sZ0J0yUeOnm8PDEaJa8pFcmTToGeiNpLymh5mQD0eToRBfJzI96h+QqLRMt5pW0ls6i2sd0lGNGueZPJiHR0YK3nq2FJS4RWTASSIltghnQTqd6JcV8odMYgUXBz0JpKKeN7Ei9Sp3YIYqdAX2D93WMY7mssg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(84970400001)(6512007)(66556008)(66476007)(5660300002)(7416002)(86362001)(41300700001)(4326008)(8936002)(316002)(82960400001)(66946007)(38100700002)(8676002)(478600001)(6506007)(26005)(2906002)(9686003)(186003)(6666004)(53546011)(6486002)(54906003)(83380400001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dno1cnhoYVpwdzEwRzlZdEVyTFpFVWNXU0dmMlN6QzBWM0EzcnNMY0thVkx2?=
 =?utf-8?B?NFFra0hrY0NSbGZNL1N0RTFYYVFwc01lSk85L3R5S1IxRWVackMzMUhnQWFm?=
 =?utf-8?B?aS9IV0FUUWNKaUtiTDZBVHR2VWYyemp5OERIVzNsUjFncDVsNlVUQXhWc05h?=
 =?utf-8?B?ZXorcDFXOW9xVElsT3VVQW5LeERtVWVYSTRBK2RBWmtNTFdWM2J4RlBVc3pG?=
 =?utf-8?B?K0pXdXZLTm54WS8vTmlnQXNCc2lybzlWeGllSUliRUhLMVE0ajVORUQrR0sx?=
 =?utf-8?B?QlB3UHZrNC9yaDcwS0QwZkZ1TFk1dHMwUk52LzQyQ1hpamdpL0lqS0dpQzhK?=
 =?utf-8?B?QXB1Qlh1MXRaQVlua29QWThkWlZ2YVM0TlVMcEx4eGZSWk15a2piMVVZVjUr?=
 =?utf-8?B?SjVpUGlZNjljeHBVNDhHQkZXTHVNSDE2YlZkOWtmaWRmM2IweHJvcG1LRVNj?=
 =?utf-8?B?ZXpVV3hML04zbTJReTFueFhWd0ZQNHpucS9ucEFNQU9mLzA5N3VnSUMwQzh5?=
 =?utf-8?B?ZEgrTFNadmZYUUtyUFlWaG8xaWlzYWlXYWRqdzFFaU5idzBnUkVFdlpOR0o4?=
 =?utf-8?B?eE4wNVowTTVRMXZnc04rU2lwZVdkU3hkQ3lMUU5nZll3dlV5S2pacG5Gbnhi?=
 =?utf-8?B?UjhMZGhZWFFxWm9MUWVwdWpTdFhzdE5CeC80d3JqRGlpRU1ZZ2Y4VTg3M281?=
 =?utf-8?B?aERhKzNHS3F2b2NkTHY4U0xWZWZpUHpDSDNISTJNTVdLK0RiR1ptdjJVbjBs?=
 =?utf-8?B?cW9RTHY5Q0g0VGRqUXZ2Y0VpUnk0Ulo3cUsreUY2UjNhYXR6azMzQm41Q0lR?=
 =?utf-8?B?eEt4NDdrZy9OK0VmNEhEakhQdFRDSnRLV29zMEtGRG1EU2tQd2RidkREMnJv?=
 =?utf-8?B?c2tETGhKd0FqVWQzK3I2VURKRTlGd2gxcnM4RXBhWm9PWUl4a0xCc1JTN0Q5?=
 =?utf-8?B?cjNQN3QzUXZtNkpicDlGcXkxd0lkZW1BOE9FNm9LWTZmYkQ4ZjBBNC9nL3Ey?=
 =?utf-8?B?UDcwNzFvQU5hdHc5RDV4cmFGQ3l3cUwxdXpGdUUzalJqN0owZ2gzRkYxVHNK?=
 =?utf-8?B?R2dSeUhkOXFNSUVtQmxVNVBrbGdjSlJleENQRVBxSm9EL2ZBVFljaElqc2tq?=
 =?utf-8?B?bjVoSnVXN2tnQXRpZDZ5TTZDcWdET0dKNU9RNUY1ODB4ZE5Lc3ozSjBpdFRh?=
 =?utf-8?B?OGRUc25zcFF3aGpkVVpuaXVNangvaDZNN0pLYk0rTnB4Z1ZKcmVUbzFBTlBv?=
 =?utf-8?B?NWFFM1ZlTFpBNWhwMDVjVVg0UXlVWEZ1ZEV0Rk0zVzRuSEljeXBGMzkydmwx?=
 =?utf-8?B?L0tNY3MzME1PdFhmaVphYjRsYTlBQWt5SEpGYi9PVjBvUmZkZWlyR256N1Zs?=
 =?utf-8?B?VHBNSVZQOXhTbysrQVdNajZWSUhSZkRRUTU1NGQ5TmRvN0FhVDkrNzJHN09Y?=
 =?utf-8?B?SC8yTEJCNmtYNkxsMTREYkRYM0UrMGxlNlg5T1F3RTVweEF4QmR0Y2lVZE9L?=
 =?utf-8?B?OGszVDFJRXhPZ3NscHkyRWJla2NkcU9DdDF5dk1LM0tOaEZ3OVF5dWo5bEdu?=
 =?utf-8?B?dlRkZTVhYk95YVNkeXBSeHIrNHpYN2I5UkF6NWQrM0dIZFg2UWlXb3ZkNVU3?=
 =?utf-8?B?NmQ0aGJuOXBwMURvVzdIdjdCeFIvUkpMVHhzNmlIdEdzMFhrTTVoSVplcDhn?=
 =?utf-8?B?d1dwWkZTd3lTQndSMGNVT3oyeERoeENkQzJvYkYrZ1JtZlpDam1aL3lTU2xo?=
 =?utf-8?B?eEZ4K0ljVlN2QkJMYzhydlVlaGNDUVJERnY5SnI5enJIQ1ZHSUpDa2w5cnFJ?=
 =?utf-8?B?TzV6dFF1ZlovU3lraE5OMFlBNkZUMllmU2VNNkRIWVJwS2Jsa0IvMmN5dk9z?=
 =?utf-8?B?N29TY0xtdFEvd3JkbFRzQzE1QnVQWkl0Y21TVWhEUkJZK3RQdEh5MGJHd3Y1?=
 =?utf-8?B?M2pScHZhVnVZU0ZlWTVuQStkM0U1WndlSi9IbkZLYU1zc0piazRiYVBSMFpH?=
 =?utf-8?B?OHlNNnNSYkFCMGw5MDVkTVpNQXJCKzlqQ09qZTZxa3lJcWFSK1RBajlKMklT?=
 =?utf-8?B?WmtpdDBSNnUrOEhyWGFLNTFmVnlaTC91ZlBGM0Nwd09EczZHSTd0K3Faa0Zw?=
 =?utf-8?B?QlF2YVoxWCt3dVVPREFZS3BFbkFoSmtSSEwxb1hDWE11YzdyWUJ2TkdJQmZq?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0307e7-3de7-47ae-df42-08db7782acb6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 02:52:13.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR8Eyev/UnihhlPDnuWY43aQ2rUgPgi3OymmFQWQnQGBHLzjrQEobyYyMbhje53SzW+gwTHweR0Aiz/DBHdcjYyV9CFLdci77bKedj6PmTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6809
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dionna Amalie Glaze wrote:
> On Tue, Jun 27, 2023 at 5:13 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > [..]
> > >
> > > The VMPL-based separation that will house the supervisor module known
> > > as SVSM can have protocols that implement a TPM command interface, or
> > > an RTMR-extension interface, and will also need to have an
> > > SVSM-specific protocol attestation report format to keep the secure
> > > chain of custody apparent. We'd have different formats and protocols
> > > in the kernel, at least, to speak to each technology.
> >
> > That's where I hope the line can be drawn, i.e. that all of this vendor
> > differentiation really only matters inside the kernel in the end.
> >
> > > I'm not sure it's worth the trouble of papering over all the... 3-4
> > > technologies with similar but still weirdly different formats and ways
> > > of doing things with an abstracted attestation ABI, especially since
> > > the output all has to be interpreted in an architecture-specific way
> > > anyway.
> >
> > This is where I need help. Can you identify where the following
> > assertion falls over:
> >
> > "The minimum viable key-server is one that can generically validate a
> > blob with an ECDSA signature".
> >
> > I.e. the fact that SEV and TDX send different length blobs is less
> > important than validating that signature.
> >
> > If it is always the case that specific fields in the blob need to be
> > decoded then yes, that weakens the assertion. However, maybe that means
> > that kernel code parses the blob and conveys that parsed info along with
> > vendor attestation payload all signed by a Linux key. I.e. still allow
> > for a unified output format + signed vendor blob and provide a path to
> > keep all the vendor specific handling internal to the kernel.
> >

First, thank you for engaging, it speeds up the iteration. This
confirmed my worry that the secondary goal of this proposal, a common
verification implementation, is indeed unachievable in the near term. A
few clarifying questions below, but I will let this go.

The primary goal, achievable on a short runway, is more for kernel
developers. It is to have a common infrastructure for marshaling vendor
payloads, provide a mechanism to facilitate kernel initiated requests to
a key-server, and to deploy a common frontend for concepts like runtime
measurement (likely as another backend to what Keys already understands
for various TPM PCR implementations).

> All the specific fields of the blob have to be decoded and subjected
> to an acceptance policy. That policy will most always be different
> across different platforms and VM owners. I wrote all of
> github.com/google/go-sev-guest, including the verification and
> validation logic, and it's going to get more complicated, and the
> sources of the data that provide validators with notions of what
> values can be trusted will be varied.

Can you provide an example? I ask only to include it in the kernel
commit log for a crisp explanation why this proposed Keys format will
continue to convey a raw vendor blob with no kernel abstraction as part
of its payload for the foreseeable future.

> The formats are not standardized. The Confidential Computing
> Consortium should be working toward that, but it's a slow process.
> There's IETF RATS. There's in-toto.io attestations. There's Azure's
> JWT thing. There's a signed serialized protocol buffer that I've
> decided is what Google is going to produce while we figure out all the
> "right" formats to use. There will be factions and absolute gridlock
> for multiple years if we require solidifying an abstraction for the
> kernel to manage all this logic before passing a report on to user
> space.

Understood. When that standardization process completes my expectation
is that it slots into the common conveyance method and no need to go
rewrite code that already knows how to interface with Keys to get
attestation evidence.

> Now, not only are the field contents important, the certificates of
> the keys that signed the report are important. Each platform has its
> own special x509v3 extensions and key hierarchy to express what parts
> of the report should be what value if signed by this key, and in TDX's
> case there are extra endpoints that you need to query to determine if
> there's an active CVE on the associated TCB version. This is how they
> avoid adding every cpu's key to the leaf certificate's CRL.
> 
> You really shouldn't be putting attestation validation logic in the
> kernel.

It was less putting validation logic in the kernel, and more hoping for
a way to abstract some common parsing in advance of a true standard
attestation format, but point taken.

> It belongs outside of the VM entirely with the party that will
> only release access keys to the VM if it can prove it's running the
> software it claims, on the platform it claims. I think Windows puts a
> remote procedure call in their guest attestation driver to the Azure
> attestation service, and that is an anti-pattern in my mind.

I can not speak to the Windows implementation, but the Linux Keys
subsystem is there to handle Key construction that may be requested by
userspace or the kernel and may be serviced by built-in keys,
device/platform instantiated keys, or keys retrieved via an upcall to
userspace.

The observation is that existing calls to request_key() in the kernel
likely have reason to be serviced by a confidential computing key server
somewhere in the chain. So, might as well enlighten the Keys subsystem
to retrieve this information and skip round trips to userspace run
vendor specific ioctls. Make the kernel as self sufficient as possible,
and make SEV, TDX, etc. developers talk more to each other about their
needs.
