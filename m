Return-Path: <linux-kselftest+bounces-43174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2018BBDD97C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 11:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AFCF4FCEB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E823630AAD6;
	Wed, 15 Oct 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGLnoEpN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B0307AEC;
	Wed, 15 Oct 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518960; cv=none; b=TK3TpYdsk+k2Py2HnIP7S0rlqYVB0F9jPxVEkebHhctr7sXLdMZSkZfXj7XEVtFLOh7KsoAT/B0bbDuNIzLYp9p+McRpMlh8Nh4Wp4JcMQtOAsJPw7R+WCRPD18w43sp58fxXEUtY6F8bZSK5sTIIsquNmeh6O3nZ2swFSZvmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518960; c=relaxed/simple;
	bh=NnFyGjBoL4vGg7ADG2ActUbXLTE11O5QDFufreKmw1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aknxa0lSCTZ6pqC/eFgF+hdHGx7U4grFbfhM8edp1r097Gm489JIKyiTHVpRiBvy856NmgL88MnEFLYmmrtZvNJ1lENdArEdcUTh1mgQwjWSSO2NgGArrwCRajbqv5rq+pM9WOa0dmh+vL3Q4mFFz+1gN8rF2bhGuvdqhElCncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGLnoEpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28134C4CEF8;
	Wed, 15 Oct 2025 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760518960;
	bh=NnFyGjBoL4vGg7ADG2ActUbXLTE11O5QDFufreKmw1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGLnoEpNwn1R41Qc3IIZWGmcD6MeEK4GVqMrDhSSc8fN7VJuVkNMDCZ6AQflu63GG
	 UK0nFSVBkXOxB/KgPc2mfZ+1Pa47f9DwOlOxLuWdZ0cEnY5WCIqelN5Gbt4+TgnOKJ
	 WKw11Oz6Xpru/Ylb9p+eAidWCosit/ZcLmNoa4aUvNQW4V75q42xXScHUgf2MFvkYl
	 D08bz/w7rnbxImSwUzRViQB6J9yV8DznSHr0alrfz+/UDiJl9aEHUX9NyVORrhAI8d
	 +q40uiiZceCBnd0y8AcQcgQB4GOeHjv2QUvMJzA8vWbPAsCqNpaJB0JUVBA9F8rXNI
	 aAwTNFMgrDruQ==
Date: Wed, 15 Oct 2025 12:02:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Itamar Dalal <dalalitamar@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"riel@surriel.com" <riel@surriel.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"harry.yoo@oracle.com" <harry.yoo@oracle.com>,
	"jannh@google.com" <jannh@google.com>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"shuah@kernel.org" <shuah@kernel.org>
Subject: Re: selftests/mm/rmap: verify correct RMAP handling of COW pages
 after fork()
Message-ID: <aO9jJ-wGR5ANmKZs@kernel.org>
References: <SN6PR04MB4048CF9A242A640B29A588EDFEE8A@SN6PR04MB4048.namprd04.prod.outlook.com>
 <8c2c9721-e2ca-488b-b7be-c58170f6ceba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c2c9721-e2ca-488b-b7be-c58170f6ceba@redhat.com>

On Wed, Oct 15, 2025 at 10:49:48AM +0200, David Hildenbrand wrote:
> On 15.10.25 10:43, Itamar Dalal wrote:
> > Add a new test `migrate.cow_after_fork` that verifies correct RMAP handling
> > of Copy-On-Write (COW) pages after fork().
> > 
> > Before a write, the parent and child share the same PFN. After a write, the
> > child’s PFN differs. This confirms that proper COW duplication occurred and
> > that RMAP correctly tracks page ownership transitions during COW events.
> > 
> > Signed-off-by: Itamar-Dalal <dalalitamar@gmail.com>
> > ---
> 
> Se my reply to your other patch.
> 
> For the next time
> 
> a) Use git-format-patch that will automatically add [PATCH]
> 
> b) Use versioning, e.g., [PATCH v1], explain changes since the last version
> under the "---" the
> 
> c) Use RESEND for resends, e.g., [PATCH v1 RESEND]
> 
> d) Use git-send-email to send mails out
> 
> The b4 tool might help as well.

And

e) please don't respin new version as soon as you get a single feedback.

https://docs.kernel.org/process/submitting-patches.html#don-t-get-discouraged-or-impatient
 

-- 
Sincerely yours,
Mike.

