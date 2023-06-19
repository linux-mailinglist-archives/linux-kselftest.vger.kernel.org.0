Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FEB734B63
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 07:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFSFiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 01:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSFiU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 01:38:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7977E188;
        Sun, 18 Jun 2023 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687153098; x=1718689098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VFXIR4yP7kC/1mRajI/wJIyImTXNAk1r8NgyhljcStI=;
  b=oA8z641J2ukWeSERpTxHyoCgBngJehQQ3ySb3kldogXIAb36CxC1qdFV
   wPOfEX/Uyw1hYtbW2XtQM/ziMJMsK9c5ZRJOknzNWr9LlNDTSUnKxB5Aj
   y4oENtAq4w3Ix6JNeZ/CF7Q7qzZryB6k+lJuHxJ23Nbj9RQej/WbAW9eV
   qV2W7FCJZJj2YdFrrE5cJvb/Xm8JK1e5ZDLYGvhra3mutrvCa1/ZuGrf/
   D/3U/iYcgeSGVfddzoyGk05FswYi/44E79L6mB8dmQzz9ce+5SG2QxOBm
   vmHBb6VCOTJ3ijSiAcI+vybepIs9vRfkpI9S8U9KlK6MPeRkxM9QfYHwA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="425499663"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="425499663"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 22:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="887788685"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="887788685"
Received: from odamavan-mobl.amr.corp.intel.com (HELO [10.209.126.182]) ([10.209.126.182])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 22:38:17 -0700
Message-ID: <fc4b3014-b592-8780-abf7-2e1ff670334e@linux.intel.com>
Date:   Sun, 18 Jun 2023 22:38:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        dhowells@redhat.com, brijesh.singh@amd.com, atishp@rivosinc.com
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dan,

On 6/12/23 12:03 PM, Dan Williams wrote:
> [ add David, Brijesh, and Atish]
> 
> Kuppuswamy Sathyanarayanan wrote:
>> In TDX guest, the second stage of the attestation process is Quote
>> generation. This process is required to convert the locally generated
>> TDREPORT into a remotely verifiable Quote. It involves sending the
>> TDREPORT data to a Quoting Enclave (QE) which will verify the
>> integrity of the TDREPORT and sign it with an attestation key.
>>
>> Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
>> allow the user agent to get the TD Quote.
>>
>> Add a kernel selftest module to verify the Quote generation feature.
>>
>> TD Quote generation involves following steps:
>>
>> * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
>> * Embed the TDREPORT data in quote buffer and request for quote
>>   generation via TDX_CMD_GET_QUOTE IOCTL request.
>> * Upon completion of the GetQuote request, check for non zero value
>>   in the status field of Quote header to make sure the generated
>>   quote is valid.
> 
> What this cover letter does not say is that this is adding another
> instance of the similar pattern as SNP_GET_REPORT.
> 
> Linux is best served when multiple vendors trying to do similar
> operations are brought together behind a common ABI. We see this in the
> history of wrangling SCSI vendors behind common interfaces. Now multiple
> confidential computing vendors trying to develop similar flows with
> differentiated formats where that differentiation need not leak over the
> ABI boundary.
> 
> My observation of SNP_GET_REPORT and TDX_CMD_GET_REPORT is that they are
> both passing blobs across the user/kernel and platform/kernel boundary
> for the purposes of unlocking other resources. To me that is a flow that
> the Keys subsystem has infrastructure to handle. It has the concept of
> upcalls and asynchronous population of blobs by handles and mechanisms
> to protect and cache those communications. Linux / the Keys subsystem
> could benefit from the enhancements it would need to cover these 2
> cases. Specifically, the benefit that when ARM and RISC-V arrive with
> similar communications with platform TSMs (Trusted Security Module) they
> can build upon the same infrastructure.
> 
> David, am I reaching with that association? My strawman mapping of
> TDX_CMD_GET_QUOTE to request_key() is something like:
> 
> request_key(coco_quote, "description", "<uuencoded tdreport>")
> 
> Where this is a common key_type for all vendors, but the description and
> arguments have room for vendor differentiation when doing the upcall to
> the platform TSM, but userspace never needs to contend with the
> different vendor formats, that is all handled internally to the kernel.
> 
> At this point I am just looking for confirmation that the "every vendor
> invent a new character device + ioctl" does not scale and a deeper
> conversation is needed. Keys is a plausible solution to that ABI
> proliferation problem.

I agree that vendor-specific interfaces do not scale, and the ABI generalization
will benefit future vendors who require similar feature support. However, such
generalization, in my opinion, will make more sense if the requirements at the top
level are also generalized. Currently, each vendor has their own attestation flow,
and the user ABI they introduced includes a lot of vendor-specific information to
support it. IMO, it is difficult to hide these vendor-specific information from the
user without generalizing the high level attestation flow.

I have included the attestation IOCTL interfaces used by S390, AMD SEV and TDX
below for reference. As you can see, each of these ARCHs uses very different
input and output data formats. It contains a lot of vendor-specific information
(like the vmpl field in struct snp_report_req or the meas_addr, arcb_adr in struct
uvio_attest). The only thing I see in common is the use of input and output blobs.

Even if we just generalize the ABI now, I'm not sure if the unified ABI we create
now will meet the requirements of RISC-v or ARM platforms when they introduce their
own attestation flow in the future. My thinking is that without some sort of
arch-agnostic high-level attestation workflow, ABI generalization has very little
benefit.

======================================================================
// Following are S390 specific attestation struct
drivers/s390/char/uvdevice.c

struct uvio_ioctl_cb {
        __u32 flags;
        __u16 uv_rc;                    /* UV header rc value */
        __u16 uv_rrc;                   /* UV header rrc value */
        __u64 argument_addr;            /* Userspace address of uvio argument */
        __u32 argument_len;
        __u8  reserved14[0x40 - 0x14];  /* must be zero */
};

#define UVIO_ATT_USER_DATA_LEN          0x100
#define UVIO_ATT_UID_LEN                0x10


struct uvio_attest {
        __u64 arcb_addr;                                /* 0x0000 */
        __u64 meas_addr;                                /* 0x0008 */
        __u64 add_data_addr;                            /* 0x0010 */
        __u8  user_data[UVIO_ATT_USER_DATA_LEN];        /* 0x0018 */
        __u8  config_uid[UVIO_ATT_UID_LEN];             /* 0x0118 */
        __u32 arcb_len;                                 /* 0x0128 */
        __u32 meas_len;                                 /* 0x012c */
        __u32 add_data_len;                             /* 0x0130 */
        __u16 user_data_len;                            /* 0x0134 */
        __u16 reserved136;                              /* 0x0136 */
};


#define UVIO_DEVICE_NAME "uv"
#define UVIO_TYPE_UVC 'u'

#define UVIO_IOCTL_ATT _IOWR(UVIO_TYPE_UVC, 0x01, struct uvio_ioctl_cb)


// Following are TDX specific interfaces
drivers/virt/coco/tdx-guest/tdx-guest.c

/**
 * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT0 IOCTL.
 *
 * @reportdata: User buffer with REPORTDATA to be included into TDREPORT.
 *              Typically it can be some nonce provided by attestation
 *              service, so the generated TDREPORT can be uniquely verified.
 * @tdreport: User buffer to store TDREPORT output from TDCALL[TDG.MR.REPORT].
 */
struct tdx_report_req {
        __u8 reportdata[TDX_REPORTDATA_LEN];
        __u8 tdreport[TDX_REPORT_LEN];
};



/* struct tdx_quote_buf: Format of Quote request buffer.
 * @version: Quote format version, filled by TD.
 * @status: Status code of Quote request, filled by VMM.
 * @in_len: Length of TDREPORT, filled by TD.
 * @out_len: Length of Quote data, filled by VMM.
 * @data: Quote data on output or TDREPORT on input.
 *
 * More details of Quote request buffer can be found in TDX
 * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
 * section titled "TDG.VP.VMCALL<GetQuote>"
 */
struct tdx_quote_buf {
        __u64 version;
        __u64 status;
        __u32 in_len;
        __u32 out_len;
        __u64 data[];
};

/* struct tdx_quote_req: Request struct for TDX_CMD_GET_QUOTE IOCTL.
 * @buf: Address of user buffer in the format of struct tdx_quote_buf.
 *       Upon successful completion of IOCTL, output is copied back to
 *       the same buffer (in struct tdx_quote_buf.data).
 * @len: Length of the Quote buffer.
 */
struct tdx_quote_req {
        __u64 buf;
        __u64 len;
};

/*
 * TDX_CMD_GET_REPORT0 - Get TDREPORT0 (a.k.a. TDREPORT subtype 0) using
 *                       TDCALL[TDG.MR.REPORT]
 *
 * Return 0 on success, -EIO on TDCALL execution failure, and
 * standard errno on other general error cases.
 */
#define TDX_CMD_GET_REPORT0              _IOWR('T', 1, struct tdx_report_req)

/*
 * TDX_CMD_GET_QUOTE - Get TD Guest Quote from QE/QGS using GetQuote
 *                     TDVMCALL.
 *
 * Returns 0 on success or standard errno on other failures.
 */
#define TDX_CMD_GET_QUOTE               _IOWR('T', 2, struct tdx_quote_req)


// Following are AMD SEV specific interfaces
drivers/virt/coco/sev-guest/sev-guest.c

struct snp_report_req {
        /* user data that should be included in the report */
        __u8 user_data[64];

        /* The vmpl level to be included in the report */
        __u32 vmpl;

        /* Must be zero filled */
        __u8 rsvd[28];
};

struct snp_report_resp {
        /* response data, see SEV-SNP spec for the format */
        __u8 data[4000];
};

struct snp_guest_request_ioctl {
        /* message version number (must be non-zero) */
        __u8 msg_version;

        /* Request and response structure address */
        __u64 req_data;
        __u64 resp_data;

        /* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
        union {
                __u64 exitinfo2;
                struct {
                        __u32 fw_error;
                        __u32 vmm_error;
                };
        };
};

/* Get SNP attestation report */
#define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_guest_request_ioctl)
======================================================================

In addition to GetReport support, each of these guest attestation drivers includes
IOCTLs to handle vendor-specific needs (such as Derived key support in the
SEV driver or RTMR Extend support in the TDX guest driver). So we cannot
completely unify all IOCTL interfaces in these drivers.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
