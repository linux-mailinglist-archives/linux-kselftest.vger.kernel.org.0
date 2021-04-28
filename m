Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86AD36D88A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhD1NsH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 09:48:07 -0400
Received: from mail-he1eur01hn2218.outbound.protection.outlook.com ([52.100.5.218]:4098
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229891AbhD1NsG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 09:48:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8VYXF5kHxcdDE0LSBHww4ncuF4mG87a9KBXIFJeTLy8OKLDbcIPQbsmNVPKp22uGrWykNyhv3WXYghgBx9UDQ+glXr4112Aa3Tf5RfAZJinb9aeXDa4OPGa80IWsP+YlDuknf6SWf93GzAa787qXfXc3N33rPuuskf6yfzeFaR0/BffvWxvPGnkRiQ4yaClE8HVzeuRq1cbB7TjmIF0cWkogF5eR6mwsfMF9+j+Tj+rvY7dHPEvjcJ6mGQJd+NVq/TBKDZwbnV0yOn9XORcqfzFzwJ2Kd55UjmFwqrDnvHvDEX/pA+KF3Oo6hXoCeuNhfYgZwJZBkT0tL6YeHAwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NegJJJsw8DC5qD87Y/UEZnZzhl/mxnLtwR4L7OUHxXs=;
 b=XfzhLUWoWvf+JEGXpGP8Tff2ubZo0Z83yk0WHrpZH3t2gejsmIXVJOQq17WTjbwxtrulIamaJfin4KJPvAZWgqe7NkcBFjuS1plsyMAspZ8OWyywOly3dCfAZJ+vlHnlLseWrRiWxORgtvL9x7CvPnYnUy7L/Ur31/19IRkZ/8ZQTk7z8whioNuSxrJGHETsQinrsea8Z/az7VXsYPYwPu+E8sBzfgOnSTr3rve4FjOeAxPZ91x2enAxJlMteSqA5m4zVwL2uatoYqjPIfaVVkYX3lHFjxNEZ3rgP5CpJ3rDsTtRyZBineCot1xGik0tR1UrNQ11bvE8DuFz/JBDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NegJJJsw8DC5qD87Y/UEZnZzhl/mxnLtwR4L7OUHxXs=;
 b=hCPyDwY5ZQSrMqFLnkmWTsfMbsnF7hAZtDmuWMhFNVanq1cyo8pRvA8lTpbT50CmjJy/E0Ylw5gFTMi1kHXDgZf4H0uMilpU/x0M+vYoaH84yypY/9mLT6ts7PtiGW93dWTB0vZTdh21Djq/E+3N+jmX421ai/KvlUWN0UJGtso=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com (2603:10a6:20b:283::19)
 by AM9PR08MB5988.eurprd08.prod.outlook.com (2603:10a6:20b:283::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 13:47:09 +0000
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f]) by AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f%7]) with mapi id 15.20.4065.028; Wed, 28 Apr 2021
 13:47:09 +0000
Date:   Wed, 28 Apr 2021 16:46:57 +0300
From:   Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Denis Lunev <den@openvz.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Like Xu <like.xu@linux.intel.com>,
        Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid
 entries count
Message-ID: <20210428134657.GA515794@dhcp-172-16-24-191.sw.ru>
References: <20210428113655.26282-1-valeriy.vdovin@virtuozzo.com>
 <871raueg7y.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871raueg7y.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To AM9PR08MB5988.eurprd08.prod.outlook.com
 (2603:10a6:20b:283::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-172-16-24-191.sw.ru (185.231.240.5) by FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend Transport; Wed, 28 Apr 2021 13:47:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfb3773a-d905-4102-cb03-08d90a4c1e52
X-MS-TrafficTypeDiagnostic: AM9PR08MB5988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR08MB59883601159F4176928F22E687409@AM9PR08MB5988.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:AM9PR08MB5988.eurprd08.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(5660300002)(83380400001)(6916009)(8676002)(38100700002)(44832011)(33656002)(66476007)(66556008)(6506007)(38350700002)(956004)(36756003)(86362001)(66946007)(7696005)(52116002)(7416002)(6666004)(186003)(2906002)(4326008)(16526019)(26005)(9686003)(54906003)(55016002)(498600001)(8936002)(1076003)(30126003);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rnMkpzsuNqNLLGZnFUae8c1gNDtRlDPN143pVlMGz+9KOzFaF+npFFxtIFWo?=
 =?us-ascii?Q?tt6iz7C8OS6sPohz43R0I6J14ECVV0oJOEeMk9Wi2qtFhNc6EIy+bF8V2nBA?=
 =?us-ascii?Q?VN4LfOIQVtAzETC+HGkvyDOHyfoZ9mgacVoVRjGkbwLk02kv7Hrv6SYPOBOQ?=
 =?us-ascii?Q?rR9dqKjrJoMIze1Dwv3Ym4/AoB8oY0fPvNPILxkGxGRI1rrg6erqiWqX+cgE?=
 =?us-ascii?Q?YJDHFh961uMzp4rKzLs7QKrWNdsBN6lIJ7/AN4/pdpxHaTr7Vzw/FR2UygkQ?=
 =?us-ascii?Q?YbaCYsxWtv6XtUWpjw8LNWX26kZKIQr/kp8v2MJuDPZ1SIHLaOLa3wbHePjy?=
 =?us-ascii?Q?aB3+OPDx6rVDDqdVqHnuU+ZmI9fnhPMoaArpoWfc7vbfca3PzTYUJfEM0Fh7?=
 =?us-ascii?Q?V+I/oMWNVN8B7g6cbwOwKMiIzFbVK4T4tx8/rzpYGlY6yrUKs+y7mbwG4DqH?=
 =?us-ascii?Q?MD237B9UUahP3tUqFtrsg4/4FeUS5lCTC2Ot1FGC9fbSC36Pr+tHysFKZYJd?=
 =?us-ascii?Q?o6y0n0q+xUoVW6cuHdxY/f1WuMIZQjmOPnMaMCMl5C4eWQ2PKVjxCMTPY+SJ?=
 =?us-ascii?Q?Wtt8h/7W8jVx05Z+hYoc2dD7ciOp7yrYluPIYEocwdPRticFzPjPEWq18ezL?=
 =?us-ascii?Q?eGYpvIAdrZAaw3mlK9XlACj2pvcwmYQxoMyAPdrfMN3AyLRZd8l5Lp1nLClx?=
 =?us-ascii?Q?t1qVIjB812K21WSkF77DY55ohOrNZ0reDpb6FTfVUyHqXmIa5FD9oci0w8J0?=
 =?us-ascii?Q?2ZAUkuOSOGScA5za9iRa8RqVwVKkdovID08t4SVyEuO7VgPKyUJhtszhv/2b?=
 =?us-ascii?Q?bQvB3oxyhJnZ3OuDYei+iXNvMUOH35s/mAAPim2f0jVCis2FsIMJyGmRq+d2?=
 =?us-ascii?Q?/fOwORqV6Mb8RaZ0MU6cHWyulnBnD/irkcckFoFNauWzflBeefJk9bs9mn5q?=
 =?us-ascii?Q?V8MII/RssqJbcDSYMHoov1Mlxoq7lEWvGjvmCkGpgkc=3D?=
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QnMt0Fu23s8ZfyDR2p4LFyPJlMRcEV3ztqbEXrWMJaUELFoaNRSnv4zqcH81?=
 =?us-ascii?Q?gwUXagqx+CUvtYpZOvOyMsUlWl6uTfGd/3oEMzxculcR/jzMDyOYKmMmfyv0?=
 =?us-ascii?Q?9Lu8PLA9eojJiwIo4lPSK1zqa5xT0WXqlujsdeGxWT1MElL9EQDHuouQmvhS?=
 =?us-ascii?Q?/n7bMlOWcH0Jv34GtDOBftjQDOo2ekDwgCCwBrD0jn9XBKV2QUxIoZfrryGP?=
 =?us-ascii?Q?s5D0ZFdJlTu92hgJWuNtMMEjVVIKXF4RW4rNkwGcAtCiWUlBId0Hj/jE20we?=
 =?us-ascii?Q?nO5EXMvm2SGWo8Cjv8SFa6CTQr2aTcXbT3Xci1Wlh1nn8eOfZvhiodzHt0pP?=
 =?us-ascii?Q?G+zRU12ynicP/jaKhebTrSpv2DKH99S6d0xhWQ7tW97YDakCDHEUTwDEE16f?=
 =?us-ascii?Q?nFRCqTn2fSCRnOclStRqgO6fiIZq1dTlN3acr+M8Q95XV9omLtZ0spMMVL6U?=
 =?us-ascii?Q?av46pKBPIFQmdC+pxQXEuLTUOgLRUMigfzyLXQAi/gPJo5rSqLPM8Mu51BO9?=
 =?us-ascii?Q?dCXyi+/3FNwDgDN9uX8dfxjnw+5rwtDTAhrc/AoI6uwVe80APWnHPzLVBbz5?=
 =?us-ascii?Q?vxtH+I0gahru/R/Fv7OvPKwxN+SziQuYjOnF/PmFxCwY+MLXm/uZf73Ba62n?=
 =?us-ascii?Q?n8FnKiUXE1fN1DcTIqVoL0J25lWzutKPEfiC4hFpengAH+Wm+LTwxXbg5Uim?=
 =?us-ascii?Q?3uhZZLzin+lHP//YIL0Tv88YU+1RHY39TkctAxLxKRABu9JBbP4Z/KaZ3xE/?=
 =?us-ascii?Q?/KGRaInK8skBBfMkBLIfOeArDD997DaoDLsdVV4PUN+RabvS9iFMKG8IMKOG?=
 =?us-ascii?Q?7vIklcTs5xIyFv+pV3gv/rudX+rsjisnlJF1m/bld4hg7nfWuu2dza8Nb34H?=
 =?us-ascii?Q?5K3FA7N/kvGVIWVrM6OkzWUhVqsO3Brp9z3DXFtqL5EMP339yDaJLXH8ii18?=
 =?us-ascii?Q?R7WWgv/O2bUQWBO6H68F6h/Fq6jtzIT2JXaJu4RAr8WZbahXC93YBxoJBmQz?=
 =?us-ascii?Q?6BNfhOwdzN/oCVysXJJJKMFsNYGE3PIYOToY3TDpe9JYZQNZRvvtFV0aWEl0?=
 =?us-ascii?Q?IYqueON3NF1MpKgQ6BV57oNNHlkvV8hB9fIddTcf5TCqwZOshs5GPmHeLOtp?=
 =?us-ascii?Q?8GqDeWiJk0k9oLjMx/VY9IjenjfQDBWGKGS/KXXHd2Y/0VtVQgRMhn2LZxEm?=
 =?us-ascii?Q?Hf4l/xcCInlZJbAoS7FGmjGvR4t3h5ShZMU4J49n+k3U78S5+qA+fz9Bn4FO?=
 =?us-ascii?Q?98JicclSKddX2N6fsVH7ez6FBvwKxFYZoAzBnsaUaueBOqmupfk0wXdKxi4E?=
 =?us-ascii?Q?gmkaiZUi2ABJ/ovlcBi4OnFV?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb3773a-d905-4102-cb03-08d90a4c1e52
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5988.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 13:47:09.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqwocrwtPDSA9BJoxeG7mFH5OIzC4fYCEGkRLqbzD6DzorwnNDlab6mkUtDh0qumos17Fb0KrmRZITYfnu3EP5WYJiEqNQqaAmmW1J8CUHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5988
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 28, 2021 at 02:38:57PM +0200, Vitaly Kuznetsov wrote:
> Valeriy Vdovin <valeriy.vdovin@virtuozzo.com> writes:
> 
> > KVM_GET_CPUID2 kvm ioctl is not very well documented, but the way it is
> > implemented in function kvm_vcpu_ioctl_get_cpuid2 suggests that even at
> > error path it will try to return number of entries to the caller. But
> > The dispatcher kvm vcpu ioctl dispatcher code in kvm_arch_vcpu_ioctl
> > ignores any output from this function if it sees the error return code.
> >
> > It's very explicit by the code that it was designed to receive some
> > small number of entries to return E2BIG along with the corrected number.
> >
> > This lost logic in the dispatcher code has been restored by removing the
> > lines that check for function return code and skip if error is found.
> > Without it, the ioctl caller will see both the number of entries and the
> > correct error.
> >
> > In selftests relevant function vcpu_get_cpuid has also been modified to
> > utilize the number of cpuid entries returned along with errno E2BIG.
> >
> > Signed-off-by: Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
> > ---
> >  arch/x86/kvm/x86.c                            | 10 +++++-----
> >  .../selftests/kvm/lib/x86_64/processor.c      | 20 +++++++++++--------
> >  2 files changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index efc7a82ab140..df8a3e44e722 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -4773,14 +4773,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> >  		r = -EFAULT;
> >  		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
> >  			goto out;
> > +
> >  		r = kvm_vcpu_ioctl_get_cpuid2(vcpu, &cpuid,
> >  					      cpuid_arg->entries);
> > -		if (r)
> > -			goto out;
> > -		r = -EFAULT;
> > -		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
> 
> It may make sense to check that 'r == -E2BIG' before trying to write
> anything back. I don't think it is correct/expected to modify nent in
> other cases (e.g. when kvm_vcpu_ioctl_get_cpuid2() returns -EFAULT)
> 
That's a good point. The caller could expect and rely on the fact that nent
is unmodified in any error case except E2BIG. I will add this in the next
version.
> > +
> > +		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid))) {
> > +			r = -EFAULT;
> >  			goto out;
> > -		r = 0;
> > +		}
> >  		break;
> 
> How is KVM userspace supposed to know if it can trust the 'nent' value
> (KVM is fixed case) or not (KVM is not fixed case)? This can probably be
> resolved with adding a new capability (but then I'm not sure the change
> is worth it to be honest).

As I see it KVM userspace should set nent to 0, and then expect any non-zero
value in return along with E2BIG. This is the same approach I've used in the
modified test code in the same patch.

> Also, if making such a change, API
> documentation in virt/kvm/api.rst needs updating.

Of course. I will add changes to the documentation and comments in case if this
change in general will have a go.

> 
> >  	}
> >  	case KVM_GET_MSRS: {
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > index a8906e60a108..a412b39ad791 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -727,17 +727,21 @@ struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
> >  
> >  	cpuid = allocate_kvm_cpuid2();
> >  	max_ent = cpuid->nent;
> > +	cpuid->nent = 0;
> >  
> > -	for (cpuid->nent = 1; cpuid->nent <= max_ent; cpuid->nent++) {
> > -		rc = ioctl(vcpu->fd, KVM_GET_CPUID2, cpuid);
> > -		if (!rc)
> > -			break;
> > +	rc = ioctl(vcpu->fd, KVM_GET_CPUID2, cpuid);
> > +	TEST_ASSERT(rc == -1 && errno == E2BIG,
> > +		    "KVM_GET_CPUID2 should return E2BIG: %d %d",
> > +		    rc, errno);
> >  
> > -		TEST_ASSERT(rc == -1 && errno == E2BIG,
> > -			    "KVM_GET_CPUID2 should either succeed or give E2BIG: %d %d",
> > -			    rc, errno);
> > -	}
> > +	TEST_ASSERT(cpuid->nent,
> > +		    "KVM_GET_CPUID2 failed to set cpuid->nent with E2BIG");
> > +
> > +	TEST_ASSERT(cpuid->nent < max_ent,
> > +		"KVM_GET_CPUID2 has %d entries, expected maximum: %d",
> > +		cpuid->nent, max_ent);
> >  
> > +	rc = ioctl(vcpu->fd, KVM_GET_CPUID2, cpuid);
> >  	TEST_ASSERT(rc == 0, "KVM_GET_CPUID2 failed, rc: %i errno: %i",
> >  		    rc, errno);
> 
> -- 
> Vitaly
> 
